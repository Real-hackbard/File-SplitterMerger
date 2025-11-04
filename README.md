# File-SplitterMerger:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) : ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Discription](https://github.com/user-attachments/assets/4a778202-1072-463a-bfa3-842226e300af) &nbsp;&nbsp;: ![File SplitterMerger](https://github.com/user-attachments/assets/f5ac1361-8ad1-479e-922e-42d6258770c8)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) &nbsp;: ![112025](https://github.com/user-attachments/assets/6c049038-ad2c-4fe3-9b7e-1ca8154910c2)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)

</br>

A file splitter/merger tool splits large files into smaller parts to facilitate transfer and then reassembles these parts into the original whole. Such tools are useful for files with size limitations or that are difficult to send. You can split files by size or number of parts and adjust the order in which the parts are merged.

</br>

![FileSplitterMerger](https://github.com/user-attachments/assets/f7200d6a-8997-4061-856e-3ab195e10ddc)

</br>

# Main Functions:

* Splitting:
    * Splits a large file into several smaller files.
    * Possible criteria include the number of files or a fixed file size (in bytes, KB, or MB).
    * Offers options for the filename and location.

* Merging:
    * Rejoins multiple individual parts into a single, original file.
    * Requires that the files to be merged were previously split using the same tool and that they are in the correct order.
    * Can sort the files to be merged by name, date, or size.

# Applications

* Transferring large files: Suitable for splitting very large files (e.g., videos or compressed archives) to send via email or other services that have size limitations.
* Document management: Special tools are available for PDF files, allowing you to merge multiple PDFs into one or split a large PDF file into individual pages.
* Format-specific tools: There are also special tools for other file formats, such as vCards, for managing contacts.
* Important note: To correctly merge a file, all parts created with the same splitter tool must be used and merged in the correct order.

# Special Features

* File Type Independence: General file splitters and mergers can process any file type by simply cutting and joining binary data. However, the resulting parts may not be usable until after merging.

* Specialized Tools: There are also specialized tools, particularly for PDFs, that offer features such as extracting specific page ranges or adjusting different page sizes during merging.

* Integrity Checking: Some tools offer automatic integrity checks (e.g., using CRC32 checksums) to ensure that the files are not corrupted during merging.

* Self-Merging Files: Some splitters can create a small, standalone executable program that can re-merge the parts without the original splitter software.

# Parameters:
Filename extensions may be considered a type of [metadata](https://en.wikipedia.org/wiki/Metadata). They are commonly used to imply information about the way data might be stored in the file. The exact definition, giving the criteria for deciding what part of the file name is its extension, belongs to the rules of the specific [file system](https://en.wikipedia.org/wiki/File_system) used

```pascal
%f%  : Determination of file names
%n%  : Determining file names without file extensions
%x%  : Determining file extensions such as rar
%p%  : Determination of specific data numbering
```

As many parameters as you can add to create your own file formats will be determined in this section. The parameters must consist of letters and be delimited by a percent sign.

```pascal
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

  // intigrate here Formats how much so you want

  i := Pos('%p:', LowerCase(sFormat));

  if i > 0 then begin 
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
```
