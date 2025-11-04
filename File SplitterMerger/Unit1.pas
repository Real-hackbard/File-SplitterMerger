unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Spin, Math, ShellAPI, FileCtrl,
  StrUtils, Registry, Menus, Vcl.Buttons;


const // Default Format Settings for parted Files
  DefaultSplitFormat = '%f%.%p%';

  (* This registry path is used to store the options in the keys;
    you can change it as you wish or omit it entirely. *)
  AppRegKey = 'Software\hackbard\SplitterMerger';
  WM_CMDLINE = WM_APP + 1;

type
  TSplitType = (stEqualParts, stBytes, stKB, stMB, stGB);

type
  TForm1 = class(TForm)
    PageControl: TPageControl;
    JoinTab: TTabSheet;
    ListBox1: TListBox;
    JoinBottomPanel: TPanel;
    OpenDialog2: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    SplitTab: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    SplitBottomPanel: TPanel;
    gbSplitSize: TGroupBox;
    SpinEdit1: TSpinEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Label5: TLabel;
    Edit3: TEdit;
    PopUpMenu1: TPopupMenu;
    jpSort: TMenuItem;
    jpClear: TMenuItem;
    Panel1: TPanel;
    Label8: TLabel;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    BitBtn6: TBitBtn;
    btnOpenSplitDir: TButton;
    Label9: TLabel;
    Label10: TLabel;
    ComboBox1: TComboBox;
    Label11: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Edit4: TEdit;
    BitBtn7: TButton;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    OpenFiles1: TMenuItem;
    N1: TMenuItem;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Label6: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    RemoveDuplicates1: TMenuItem;
    N2: TMenuItem;
    Moveup1: TMenuItem;
    Mocedown1: TMenuItem;
    TabSheet1: TTabSheet;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure BitBtn7Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure btnOpenSplitDirClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jpSortClick(Sender: TObject);
    procedure jpClearClick(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure OpenFiles1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RemoveDuplicates1Click(Sender: TObject);
    procedure ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Moveup1Click(Sender: TObject);
    procedure Mocedown1Click(Sender: TObject);
  private
    { Private declarations }
    FBusy: Boolean;
    FCancel: Boolean;
    FLastFolder: string;
    FSplitFileSize: Int64;
    FSplitParts: Integer;
    FSplitPartSize: Int64;
    FMergeFileSize: Int64;
    FDone: Boolean;
    procedure MergeFiles(const AJoinFile: string; AFiles: TStrings);
    procedure GetSplitFileSize;
    procedure CalcSplitResults;
    procedure SplitFile(const AFile, AFolder, AFormat: string);
    procedure SaveSplitSettings;
    procedure SaveMergeSettings;
    function GetSplitType: TSplitType;
    procedure SetSplitType(const Value: TSplitType);
    function GetFileSize(const AFile: string): Int64;
    procedure ShowMergeFileSize;
  public
    { Public declarations }
    flbHorzScrollWidth: Integer;
    procedure MsgCommand(var Message: TMessage); message WM_CMDLINE;
    procedure WMDROPFILES(var Msg: TMessage);
    procedure LBWindowProc(var Message: TMessage);
    procedure AddFile(sFileName: string);
  published
    procedure ChangeSplitOptions(Sender: TObject);
  end;

var
  Form1: TForm1;
  OldLBWindowProc: TWndMethod;
  NumY, NumX: Integer;

implementation

{$R *.dfm}
procedure TForm1.SaveSplitSettings;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(AppRegKey, True) then begin
      Reg.WriteInteger('LastPage', PageControl.ActivePageIndex);
      Reg.WriteString('LastFolder', FLastFolder);
      Reg.WriteInteger('SplitSize', SpinEdit1.Value);
      Reg.WriteInteger('SplitType', Ord(GetSplitType));
      Reg.WriteString('SplitFormat', Edit3.Text);
      Reg.WriteInteger('Quick', ComboBox1.ItemIndex);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm1.SaveMergeSettings;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(AppRegKey, True) then begin
      Reg.WriteInteger('LastPage', PageControl.ActivePageIndex);
      Reg.WriteString('LastFolder', FLastFolder);
      //Reg.WriteInteger('Size', SpinEdit1.Value);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  Reg: TRegistry;
  iPage: Integer;
begin
  //SpinEdit1.MinValue := 1;
  SpinEdit1.MaxValue := MaxInt;
  //SpinEdit1.Value := 10;
  // Load saved settings:
  iPage := 0;
  Reg := TRegistry.Create(KEY_READ);

  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(AppRegKey) then begin

      if Reg.ValueExists('LastPage') then begin
        iPage := Reg.ReadInteger('LastPage');
        FLastFolder := Reg.ReadString('LastFolder');
      end;

      if Reg.ValueExists('SplitSize') then begin
        SpinEdit1.Value := Reg.ReadInteger('SplitSize');
        //ComboBox1.ItemIndex := Reg.ReadInteger('Quick');
        Edit3.Text := Reg.ReadString('SplitFormat');
        SetSplitType(TSplitType(Reg.ReadInteger('SplitType')));
      end;

      if Reg.ValueExists('Quick') then begin
        ComboBox1.ItemIndex := Reg.ReadInteger('Quick');
      end;

      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;

  if (iPage >= 0) and (iPage < PageControl.PageCount) then
    PageControl.ActivePageIndex := iPage;
  if ParamCount > 0 then
    PostMessage(Handle, WM_CMDLINE, 0, 0);
end;

procedure TForm1.AddFile(sFileName: string);
begin
  ListBox1.Items.Add(sFilename);
end;

procedure TForm1.LBWindowProc(var Message: TMessage);
begin
  if Message.Msg = WM_DROPFILES then
    WMDROPFILES(Message); // handle WM_DROPFILES message
  OldLBWindowProc(Message);
  // call default ListBox1 WindowProc method to handle all other messages
end;

procedure TForm1.WMDROPFILES(var Msg: TMessage);
var
  pcFileName: PChar;
  i, iSize, iFileCount: integer;
begin
  pcFileName := ''; // to avoid compiler warning message
  iFileCount := DragQueryFile(Msg.wParam, $FFFFFFFF, pcFileName, 255);
  for i := 0 to iFileCount - 1 do
  begin
    iSize := DragQueryFile(Msg.wParam, i, nil, 0) + 1;
    pcFileName := StrAlloc(iSize);
    DragQueryFile(Msg.wParam, i, pcFileName, iSize);
    if FileExists(pcFileName) then
      AddFile(pcFileName); // method to add each file
    StrDispose(pcFileName);
  end;
  DragFinish(Msg.wParam);
end;

procedure GetAllFilesExtra(List: TStrings);
var
  Path: String;
  Search: TSearchRec;
begin
  Path := ExtractFilePath(ParamStr(0));

  if FindFirst(Path + '*.*', faAnyFile, Search) = 0 then
  try
    repeat
      if (Search.Attr <> faDirectory) and (Search.Name[1] <> '.') then
        List.Add(Path + Search.Name);
    until FindNext(Search) <> 0;
  finally
    FindClose(Search);
  end;
end;

procedure IcoToBmpA(Ico: TIcon; Bmp: TBitmap; SmallIcon: Boolean);
var
  WH: Byte; // Width and Height
begin
  with Bmp do
  begin
    Canvas.Brush.Color := clFuchsia;
    TransparentColor := clFuchsia;

    Width := 16; Height := 16;
    Canvas.Draw(0, 0, Ico);

    if SmallIcon then
      WH := 16
    else
      WH := 32;
    Canvas.StretchDraw(Rect(0, 0, WH, WH), Bmp);
    Width := WH; Height := WH;

    Transparent :=  True;
  end;
end;

procedure GetIconFromFileB(const FileName: String; Icon: TIcon;
  SmallIcon: Boolean);
var
  sfi: TSHFILEINFO;
const
  uFlags : array[Boolean] of DWord = (SHGFI_LARGEICON, SHGFI_SMALLICON);
begin
  if SHGetFileInfo(PChar(FileName), 0, sfi, SizeOf(sfi), SHGFI_ICON or
     uFlags[SmallIcon]) <> 0 then
    Icon.Handle := sfi.hIcon;
end;

procedure DrawListBoxExtra(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
const
  Col1: array [Boolean] of TColor = ($00F8F8F8, clWindow);
  Col2: array [Boolean] of TColor = (clInactiveCaptionText, clWindowText);
var
  Icon: TIcon;
  Bmp: TBitmap;
begin
  with (Control as TListbox) do
  begin
    Icon := TIcon.Create;
    Bmp := TBitmap.Create;
    try
      if odSelected in State then
        Canvas.Font.Color := clCaptionText
      else
      begin
        Bmp.Canvas.Brush.Color := Canvas.Brush.Color;
        Canvas.Brush.Color := Col1[Odd(Index)];
        Canvas.Font.Color := Col2[(Control as TListBox).Enabled];
      end;
      GetIconFromFileB(Items[Index], Icon, True);
      IcoToBmpA(Icon, Bmp, True);
      Canvas.TextRect(Rect, Rect.Left + Bmp.Width + 2, Rect.Top + 2, Items[Index]);
      Canvas.Draw(Rect.Left, Rect.Top, Bmp);
    finally
      Bmp.Free;
      Icon.Free;
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListBox1.WindowProc := OldLBWindowProc;
  DragAcceptFiles(ListBox1.Handle, False);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not FBusy;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // store defualt WindowProc
  OldLBWindowProc := ListBox1.WindowProc;
  // replace default WindowProc
  ListBox1.WindowProc := LBWindowProc;
  // now ListBox1 accept dropped files
  DragAcceptFiles(ListBox1.Handle, True);

  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  Edit3.Hint := 'Format Settings:' +#13+
                '------------' +#13+
                '%f%=Filename' +#13+
                '%n%=Name only' +#13+
                '%x%=Extension' +#13+
                '%p%=Part number' +#13+
                '------------' +#13+
                'Use a period in between.';
end;

procedure TForm1.FormDblClick(Sender: TObject);
begin
  Listbox1.Perform(LB_SetHorizontalExtent, 1000, Longint(0));
end;

procedure TForm1.PageControlChanging(Sender: TObject;
                                        var AllowChange: Boolean);
begin
  AllowChange := not FBusy;
end;

function TForm1.GetFileSize(const AFile: string): Int64;
var
  SR: TSearchRec;
begin
  if FindFirst(AFile, 0, SR) = 0 then begin
    Int64Rec(Result).Lo := SR.FindData.nFileSizeLow;
    Int64Rec(Result).Hi := SR.FindData.nFileSizeHigh;
    SysUtils.FindClose(SR);
  end else
    Result := -1;
end;

procedure TForm1.MsgCommand(var Message: TMessage);
var
  bOK: Boolean;
  sOpt, sValue, sTemp: string;
  i: Integer;
  slFiles: TStringList;
  SR: TSearchRec;
  procedure ParseOption(const S: string);
  begin
    sOpt := '';
    sValue := S;
    if (S[1] = '/') and (Length(S) > 2) then begin
      sOpt := UpperCase(S[2]);
      Delete(sValue, 1, Pos('=', sValue));
    end;
  end;
begin
  { Command line syntax:
    /S[PLIT]=#[B|K|M|G|E] [/O[UTPATH]=path] [/F[ORMAT]=format] filename
    /J[OIN]=filename (file1 file2 [file3...]|wildcard)
  }
  bOK := False;
  FDone := False;
  try
    ParseOption(ParamStr(1));
    if sOpt = 'S' then begin // SPLIT

      PageControl.ActivePage := SplitTab;
      RadioButton4.Checked := True;
      sValue := UpperCase(sValue);
      sTemp := '';
      for i := 1 to Length(sValue) do begin
        if sValue[i] in ['0'..'9'] then
          sTemp := sTemp + sValue[i]
        else begin
          case sValue[i] of
            'B': RadioButton4.Checked := True;
            'K': RadioButton3.Checked := True;
            'M': RadioButton2.Checked := True;
            'G': RadioButton1.Checked := True;
            'E': RadioButton5.Checked := True;
            else
              Exit;
          end;
          break;
        end;
      end;
      i := StrToIntDef(sTemp, 0);
      if i < 1 then
        Exit;
      SpinEdit1.Value := i;
      for i := 2 to ParamCount do begin
        ParseOption(ParamStr(i));
        if sOpt = 'F' then
          Edit3.Text := sValue
        else if sOpt = 'O' then
          Edit2.Text := sValue
        else if (sOpt = '') and (Edit1.Text = '') then
          Edit1.Text := sValue
        else
          Exit;
      end;
      bOK := True;
      Application.ProcessMessages;
      BitBtn1Click(nil);

    end else if sOpt = 'J' then begin // MERGE

      PageControl.ActivePage := JoinTab;
      Edit4.Text := sValue;
      slFiles := TStringList.Create;
      try
        slFiles.Sorted := True;
        for i := 2 to ParamCount do begin
          sTemp := ParamStr(i);
          if (Pos('*', sTemp) > 0) or (Pos('?', sTemp) > 0) then begin
            sOpt := ExtractFilePath(sTemp);
            if FindFirst(sTemp, 0, SR) = 0 then begin
              repeat
                slFiles.Add(sOpt + SR.Name);
              until FindNext(SR) <> 0;
              SysUtils.FindClose(SR);
            end;
            ListBox1.Items.AddStrings(slFiles);
            slFiles.Clear;
          end else
            ListBox1.Items.Add(sTemp);
        end;
      finally
        slFiles.Free;
      end;
      if (Edit4.Text = '') or (ListBox1.Count < 2) then
        Exit;
      bOK := True;
      Application.ProcessMessages;
      BitBtn6Click(nil);

    end;
    if FDone then
      Close;
  finally
    if not bOK then
      MessageDlg('Invalid command-line arguments.' +
        #13#10#13#10'Split syntax:'#13#10 +
        '/S[PLIT]=#[B|K|M|G|E] [/O[UTPATH]=path] [/F[ORMAT]=format] filename' +
        #13#10#13#10'Merge syntax:'#13#10 +
        '/J[OIN]=filename (file1 file2 [file3...]|wildcard)',
        mtError, [mbOK], 0);
  end;
end;

procedure TForm1.OpenFiles1Click(Sender: TObject);
begin
  BitBtn2.Click;
end;

{------------------------------------------------------------------- Merge ----}

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  if Edit4.Text <> '' then
    SaveDialog1.InitialDir := ExtractFileDir(Edit4.Text)
  else if FLastFolder <> '' then
    SaveDialog1.InitialDir := FLastFolder;

  if SaveDialog1.Execute then begin
    Edit4.Text := SaveDialog1.FileName;
    FLastFolder := ExtractFileDir(Edit4.Text);
  end;
end;

procedure TForm1.ShowMergeFileSize;
begin
  StatusBar1.Panels[1].Text :=
    Format('%.0n bytes', [FMergeFileSize * 1.0]);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  sDir: string;
begin
  if SpinEdit1.Value = 0 then begin
  Beep;
  MessageDlg('I cant split 0 size',mtInformation, [mbOK], 0);
  Exit;
  end;

  if Edit1.Text = '' then begin
    Beep;
    MessageDlg('The Filename to Split is required.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Edit2.Text = '' then begin
    Beep;
    MessageDlg('The Output Folder is required.', mtInformation, [mbOK], 0);
    Exit;
  end;

  // Double-duty as a cancel button
  if FBusy then begin
    FCancel := True;
    Exit;
  end;

  if not DirectoryExists(Edit2.Text + '\Split')
   then ForceDirectories(Edit2.Text + '\Split');

  Screen.Cursor := crHourGlass;
  StatusBar1.Panels[5].Text := 'Merging, wait..';
  GetSplitFileSize;

  if FSplitParts = 0 then
    Exit;

  sDir := ExcludeTrailingPathDelimiter(Edit2.Text + '\Split');

  if sDir = '' then
    sDir := ExtractFileDir(Edit1.Text);

  if not DirectoryExists(sDir) then begin
    if MessageDlg('The output folder does not exist, Create it?',
                  mtConfirmation, [mbYes, mbCancel], 0) = mrCancel then
      Exit;

    if not ForceDirectories(sDir) then begin
      MessageDlg(SysErrorMessage(GetLastError), mtError, [mbOK], 0);
      Exit;
    end;
  end;

  if Edit3.Text = '' then
     Edit3.Text := DefaultSplitFormat;

  if Pos('%P', UpperCase(Edit3.Text)) = 0 then begin
    MessageDlg('Invalid filename format,Leave blank to use the default.',
               mtError, [mbOK], 0);
    Edit3.SetFocus;
  end;
  SaveSplitSettings;

  BitBtn1.Caption := 'Cancel';
  FCancel := False;
  FBusy := True;

  try
    SplitFile(Edit1.Text, sDir, Edit3.Text);
  finally
    FBusy := False;
    ProgressBar1.Position := Progressbar1.Max;
    StatusBar1.Panels[5].Text := 'finsh';
    BitBtn1.Caption := '&Split';
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  i: Integer;
  slTemp: TStringList;
begin
  StatusBar1.SetFocus;

  if FLastFolder <> '' then
    OpenDialog2.InitialDir := FLastFolder
  else
  if Edit4.Text <> '' then
    OpenDialog2.InitialDir := ExtractFileDir(Edit4.Text);

  if not OpenDialog2.Execute then
    Exit;
  slTemp := TStringList.Create;

  try
    slTemp.Assign(OpenDialog2.Files);
    slTemp.Sort;
    for i := 0 to slTemp.Count - 1 do
      if ListBox1.Items.IndexOf(slTemp[i]) < 0 then
      begin
        ListBox1.Items.Add(slTemp[i]);
        FMergeFileSize := FMergeFileSize + GetFileSize(slTemp[i]);
      end;
    FLastFolder := ExtractFileDir(slTemp[0]);
  finally
    slTemp.Free;
    if CheckBox2.Checked = true then RemoveDuplicates1.Click;
  end;
  ShowMergeFileSize;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
  ListBox1.Clear;
  FMergeFileSize := 0;
  ShowMergeFileSize;

  StatusBar1.Panels[1].Text := '0 bytes';
  StatusBar1.Panels[3].Text := '0';
  StatusBar1.Panels[5].Text := 'ready.';
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
  i: Integer;
begin
  StatusBar1.SetFocus;
  for i := 1 to ListBox1.Count - 1 do begin
    if ListBox1.Selected[i] then begin
      ListBox1.Items.Exchange(i, i - 1);
      ListBox1.Selected[i - 1] := True;
    end;
  end;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
  i: Integer;
begin
  StatusBar1.SetFocus;
  for i := ListBox1.Count - 2 downto 0 do begin
    if ListBox1.Selected[i] then begin
      ListBox1.Items.Exchange(i, i + 1);
      ListBox1.Selected[i + 1] := True;
    end;
  end;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
  // Does double-duty as the cancel button
  if FBusy then begin
    FCancel := True;
    Exit;
  end;

  if ListBox1.Count < 2 then begin
    MessageDlg('Select two or more files to join.', mtInformation, [mbOK], 0);
    BitBtn2.SetFocus;
  end;

  if Edit4.Text = '' then begin
    Beep;
    MessageDlg('The Output Filename is required.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if CheckBox1.Checked then jpSort.Click;
  Screen.Cursor := crHourGlass;


  SaveMergeSettings;
  BitBtn2.Enabled := False;
  BitBtn3.Enabled := False;
  BitBtn4.Enabled := False;
  BitBtn5.Enabled := False;
  BitBtn6.Caption := 'Cancel';
  FCancel := False;
  FBusy := True;
  try
    MergeFiles(Edit4.Text, ListBox1.Items);
  finally
    FBusy := False;
    ProgressBar2.Position := ProgressBar2.Max;
    BitBtn2.Enabled := True;
    BitBtn3.Enabled := True;
    BitBtn4.Enabled := True;
    BitBtn5.Enabled := True;
    BitBtn6.Caption := '&Merge';
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.jpSortClick(Sender: TObject);
var
  slTemp: TStringList;
begin
  slTemp := TStringList.Create;

  try
    slTemp.Assign(ListBox1.Items);
    slTemp.Sort;
    ListBox1.Items.Assign(slTemp);
  finally
    slTemp.Free;
  end;
end;

procedure TForm1.ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Num1, Num2 : Integer;
  Point1, Point2: TPoint;
begin
  Point1.X:=NumX;
  Point1.Y:=NumY;
  Point2.X:=X;
  Point2.Y:=Y;
  with Source as TListBox do
  begin
    Num2:=ListBox1.ItemAtPos(Point1, True);
    Num1:=ListBox1.ItemAtPos(Point2, True);
    ListBox1.Items.Move(Num2, Num1);
  end;
end;

procedure TForm1.ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Source=ListBox1;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
 Len, i: Integer;
 NewText: String;
begin
  NewText:=Listbox1.Items[Index];

  with Listbox1.Canvas do
  begin
    // Setting the visibility range of an item
    FillRect(Rect);
    TextOut(Rect.Left + 1, Rect.Top, NewText);
    Len := TextWidth(NewText) + Rect.Left + 30;
    if Len>flbHorzScrollWidth then
    begin
      flbHorzScrollWidth:=Len;
      Listbox1.Perform(LB_SETHORIZONTALEXTENT, flbHorzScrollWidth, 0 );
    end;
  end;
  DrawListBoxExtra(Control, Index, Rect, State);

  FMergeFileSize := 0;
  try
    for i := 0 to (ListBox1.Items.Count) - 1 do
      begin
        FMergeFileSize := FMergeFileSize + GetFileSize(ListBox1.Items.Strings[i]);
      end;
  finally
  ShowMergeFileSize;
  end;
end;

procedure TForm1.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  NumY:=Y;
  NumX:=X;
end;

procedure TForm1.jpClearClick(Sender: TObject);
var
  i: Integer;
begin
  StatusBar1.SetFocus;
  for i := 0 to ListBox1.Count - 1 do
    if ListBox1.Selected[i] then
      FMergeFileSize := FMergeFileSize - GetFileSize(ListBox1.Items[i]);
      ListBox1.DeleteSelected;
      ShowMergeFileSize;
end;

procedure TForm1.MergeFiles(const AJoinFile: string; AFiles: TStrings);
var
  sSource, sTarget, sTemp: string;
  fsSource, fsTarget: TFileStream;
  f: Integer;
begin
  Screen.Cursor := crHourGlass;
  StatusBar1.SetFocus;
  sTarget := AJoinFile;
  ProgressBar2.Max := AFiles.Count;
  ProgressBar2.Position := 0;

  // Start by just copying the first file to the new name:
  sSource := AFiles[0];

  if not CopyFile(PChar(sSource), PChar(sTarget), False) then begin
    sTemp := SysErrorMessage(GetLastError);
    MessageDlg(sTemp, mtError, [mbOK], 0);
    Exit;
  end;

  ProgressBar2.StepIt;

  // Open a filestream on the target file & position to the end:
  fsTarget := TFileStream.Create(sTarget, fmOpenReadWrite, fmShareExclusive);

  try
    fsTarget.Seek(0, soFromEnd);
    f := 1; // Already did the first one!
    while (f < AFiles.Count) and not FCancel do begin
      sSource := AFiles[f];
      fsSource := TFileStream.Create(sSource, fmOpenRead, fmShareDenyWrite);
      try
        fsTarget.CopyFrom(fsSource, 0);
      finally
        fsSource.Free;
      end;
      ProgressBar2.StepIt;
      StatusBar1.Panels[3].Text := IntToStr(ProGressBar2.Position);
      Application.ProcessMessages;
      Inc(f);
    end;
    FDone := not FCancel;
  finally
    fsTarget.Free;
    Screen.Cursor := crDefault;
    ProgressBar2.Position := ProgressBar2.Max;
  end;
  if FCancel then
    DeleteFile(sTarget);
end;

procedure TForm1.Mocedown1Click(Sender: TObject);
begin
  BitBtn5.Click;
end;

procedure TForm1.Moveup1Click(Sender: TObject);
begin
  BitBtn4.Click;
end;

{------------------------------------------------------------------ Split -----}

function TForm1.GetSplitType: TSplitType;
begin
  if RadioButton5.Checked then
    Result := stEqualParts
  else if RadioButton4.Checked then
    Result := stBytes
  else if RadioButton3.Checked then
    Result := stKB
  else if RadioButton2.Checked then
    Result := stMB
  else if RadioButton1.Checked then
    Result := stGB
  else
    raise Exception.Create('No split type selected.');
end;

procedure TForm1.SetSplitType(const Value: TSplitType);
begin
  case Value of
    stEqualParts:
      RadioButton5.Checked := True;
    stBytes:
      RadioButton4.Checked := True;
    stKB:
      RadioButton3.Checked := True;
    stMB:
      RadioButton2.Checked := True;
    stGB:
      RadioButton1.Checked := True;
  end;
end;

procedure TForm1.GetSplitFileSize;
begin
  if FBusy then Exit;

  if Edit1.Text = '' then begin
    FSplitFileSize := 0;
    StatusBar1.Panels[1].Text := ' ? '
  end else begin
    FSplitFileSize := GetFileSize(Edit1.Text);
    if FSplitFileSize >= 0 then
      StatusBar1.Panels[1].Text := Format(' %.0n bytes', [FSplitFileSize * 1.0])
    else begin
      StatusBar1.Panels[1].Text := ' File not found';
      FSplitFileSize := 0;
    end;
  end;
  CalcSplitResults;
end;

procedure TForm1.CalcSplitResults;
var
  st: TSplitType;
begin
  if FBusy then
    Exit;
  if FSplitFileSize = 0 then begin
    Label13.Caption := ' ? ';
    Exit;
  end;
  st := GetSplitType;

  if st = stEqualParts then begin
    FSplitParts := SpinEdit1.Value;
    FSplitPartSize := FSplitFileSize div FSplitParts;
    while (FSplitPartSize * FSplitParts) < FSplitFileSize do
      Inc(FSplitPartSize);
  end else begin
    FSplitPartSize := SpinEdit1.Value;

    if st = stKB then
      FSplitPartSize := FSplitPartSize * 1024
    else if st = stMB then
      FSplitPartSize := FSplitPartSize * 1024 * 1024
    else if st = stGB then
      FSplitPartSize := FSplitPartSize * 1024 * 1024 * 1024;

    if FSplitPartSize < FSplitFileSize then begin
      FSplitParts := FSplitFileSize div FSplitPartSize;
      if FSplitFileSize mod FSplitPartSize > 0 then
        Inc(FSplitParts);
    end else
      FSplitParts := 0;
  end;

  if FSplitParts = 0 then begin
    Label13.Caption := ' Will not split: parts > whole';
    Exit;
  end;

  if (FSplitParts * FSplitPartSize) = FSplitFileSize then
    Label13.Caption :=
      Format(' %d parts of %.0n bytes', [FSplitParts, FSplitPartSize * 1.0])
  else
    Label13.Caption :=
      Format(' %d parts of %.0n bytes, 1 of %.0n bytes',
             [Pred(FSplitParts), FSplitPartSize * 1.0,
              (FSplitFileSize - (Pred(FSplitParts) * FSplitPartSize)) * 1.0]);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if FBusy then
    Exit;
  //if Edit1.Text <> '' then
    //OpenDialog1.InitialDir := ExtractFileDir(Edit1.Text);
  if OpenDialog1.Execute then begin
    Edit1.Text := OpenDialog1.FileName;
    FLastFolder := ExtractFileDir(Edit1.Text);
    GetSplitFileSize;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  sDir: string;
begin
  sDir := Edit2.Text;
  if sDir = '' then
    sDir := ExtractFileDir(Edit1.Text);
  if SelectDirectory('Split Output Folder', '', sDir) then begin
    Edit2.Text := sDir;
    FLastFolder := sDir;
  end;
end;

procedure TForm1.btnOpenSplitDirClick(Sender: TObject);
var
  sDir: string;
begin
  sDir := Edit2.Text;
  if (sDir = '') and (Edit1.Text <> '') then
    sDir := ExtractFileDir(Edit1.Text);
  if sDir <> '' then begin
    if DirectoryExists(sDir) then
      ShellExecute(0, 'open', PChar(sDir), nil, nil, SW_SHOWNORMAL)
    else
      MessageDlg('Path not found: ' + sDir, mtError, [mbOK], 0);
  end;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
  GetSplitFileSize;
end;

procedure TForm1.ChangeSplitOptions(Sender: TObject);
begin
  CalcSplitResults;
  if RadioButton1.Checked = true then Label9.Caption := 'GigaByte';
  if RadioButton2.Checked = true then Label9.Caption := 'MegaByte';
  if RadioButton3.Checked = true then Label9.Caption := 'KiloByte';
  if RadioButton4.Checked = true then Label9.Caption := 'Byte';
  if RadioButton5.Checked = true then Label9.Caption := 'Equal';
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0 : begin
        SpinEdit1.Value := 100;
        RadioButton4.Checked := True;
      end;
  1 : begin
        SpinEdit1.Value := 1;
        RadioButton3.Checked := True;
      end;
  2 : begin
        SpinEdit1.Value := 100;
        RadioButton3.Checked := True;
      end;
  3 : begin
        SpinEdit1.Value := 1;
        RadioButton2.Checked := True;
      end;
  4 : begin
        SpinEdit1.Value := 10;
        RadioButton2.Checked := True;
      end;
  5 : begin
        SpinEdit1.Value := 100;
        RadioButton2.Checked := True;
      end;
  6 : begin
        SpinEdit1.Value := 200;
        RadioButton2.Checked := True;
      end;
  7 : begin
        SpinEdit1.Value := 1;
        RadioButton1.Checked := True;
      end;
  end;
end;

procedure TForm1.RadioButton5Click(Sender: TObject);
begin
  if RadioButton5.Checked and (SpinEdit1.Value > 1000) then
    SpinEdit1.Value := 1000;
  ChangeSplitOptions(Sender);
end;

procedure TForm1.RemoveDuplicates1Click(Sender: TObject);
var
  lStringList: TStringList;
begin
  Screen.Cursor := crHourGlass;
  lStringList := TStringList.Create;
  try
    lStringList.Duplicates := dupIgnore;
    lStringList.Sorted := true;
    lStringList.Assign(ListBox1.Items);
    ListBox1.Items.Assign(lStringList);
  finally
    lStringList.free;
    StatusBar1.Panels[3].Text := IntToStr(ListBox1.Items.Count);
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.SplitFile(const AFile, AFolder, AFormat: string);
var
  i: Integer;
  sTarget, sFormat: string;
  fsSource, fsTarget: TFileStream;
  iTotal, iChunk: Int64;
  iPart: Integer;
begin
  StatusBar1.SetFocus;
  ProgressBar1.Max := FSplitParts;
  ProgressBar1.Position := 0;
  StatusBar1.Panels[5].Text := 'Splitting wait..';
  sTarget := ExtractFileName(AFile);
  sFormat := StringReplace(AFormat, '%f%', sTarget,
                           [rfReplaceAll, rfIgnoreCase]);
  sFormat := StringReplace(sFormat, '%n%', ChangeFileExt(sTarget, ''),
                           [rfReplaceAll, rfIgnoreCase]);
  sFormat := StringReplace(sFormat, '%x%', Copy(ExtractFileExt(sTarget), 2, MaxInt),
                           [rfReplaceAll, rfIgnoreCase]);
  i := Pos('%p:', LowerCase(sFormat));

  if i > 0 then begin // You can specify the # of digits using %p:#%
    Delete(sFormat, i, 3);
    iPart := PosEx('%', sFormat, i);
    i := StrToIntDef(Copy(sFormat, i, iPart - i), 3);
    Delete(sFormat, i, iPart - i + 1);
  end else begin
    sTarget := '%0:.' + IntToStr( Max(3, Length(IntToStr(FSplitParts))) ) + 'd';
    sFormat := StringReplace(sFormat, '%p%', sTarget,
                             [rfReplaceAll, rfIgnoreCase]);
  end;

  sFormat := IncludeTrailingPathDelimiter(AFolder) + sFormat;
  iPart := -1;
  fsSource := TFileStream.Create(AFile, fmOpenRead, fmShareDenyWrite);

  try
    iTotal := fsSource.Size;
    while (iTotal > 0) and not FCancel do begin
      Inc(iPart);
      sTarget := Format(sFormat, [iPart]);
      iChunk := Min(FSplitPartSize, iTotal);
      iTotal := iTotal - iChunk;
      fsTarget := TFileStream.Create(sTarget, fmCreate, fmShareExclusive);

      try
        fsTarget.CopyFrom(fsSource, iChunk);
      finally
        fsTarget.Free;
      end;

      ProgressBar1.StepIt;
      StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
      Application.ProcessMessages;
    end;
    FDone := not FCancel;
  finally
    fsSource.Free;
    StatusBar1.Panels[5].Text := 'finsh';
  end;
  if FCancel then
    for i := iPart downto 0 do
      DeleteFile(Format(sFormat, [iPart]));
end;

end.
