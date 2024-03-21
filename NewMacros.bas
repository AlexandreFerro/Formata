Attribute VB_Name = "NewMacros"
Public z, autor, musica, nomemus As String

Sub Formata()
Attribute Formata.VB_ProcData.VB_Invoke_Func = "Project.NewMacros.Formata3"

   UserForm2.Show
    ' Muda o diretório para o específico
    'ChangeFileOpenDirectory "D:\Users\i1819708\Music\"
    ' Abre o arquivo escolhido no Form
    Documents.Open FileName:=z, _
        ConfirmConversions:=False, ReadOnly:=False, AddToRecentFiles:=False, _
        PasswordDocument:="", PasswordTemplate:="", Revert:=False, _
        WritePasswordDocument:="", WritePasswordTemplate:="", Format:= _
        wdOpenFormatAuto, XMLTransform:="", Encoding:=65001
              
        
    ' Localiza a posição do caracter "-"
        testPos = InStr(1, z, "-")
        testPos2 = InStr(1, z, ".txt")
        
        'MsgBox testPos
        'MsgBox testPos2
        
        nomemus = Left(z, testPos2 - 1)
        'MsgBox nomemus
        
        'Autor = Left(z, testPos - 2)
        autor = Left(nomemus, testPos - 2)
        'MsgBox autor
        musica = Mid(nomemus, testPos + 2)
        'Musica = Mid(z, testPos + 2, testPos2 - 1)
        
        ' MsgBox musica
        
       ActiveDocument.SaveAs2 FileName:=(musica + " - " + autor + ".docx"), _
       FileFormat:=wdFormatXMLDocument, LockComments:=False, Password:="", _
       AddToRecentFiles:=True, WritePassword:="", ReadOnlyRecommended:=False, _
       EmbedTrueTypeFonts:=False, SaveNativePictureFormat:=False, SaveFormsData _
       :=False, SaveAsAOCELetter:=False, CompatibilityMode:=15
       
     ' Seleciona a primeira linha até o fim e deleta
        Selection.EndKey Unit:=wdLine, Extend:=wdExtend
        Selection.Cut
           
    ' Chama outra macro
      AdicCabec
      
End Sub

Sub AdicCabec()
'Declara as variáveis
Dim Cabecintervalo As Range

'A variável Cabecintervalo é igual ao Cabeçalho do documento
Set Cabecintervalo = ActiveDocument.Sections.Item(1).Headers(wdHeaderFooterPrimary).Range

'Formata o Texto que foi adicionado no cabeçalho do documento

With Cabecintervalo

' Insere o nome da música no cabeçalho e formata
    .Text = musica
    .ParagraphFormat.Alignment = wdAlignParagraphCenter
    .Font.Name = "Times New Roman"
    .Font.Size = 26
    .Collapse Direction:=wdCollapseEnd
End With

' With Selection
    '.Collapse Direction:=wdCollapseEnd
'    .TypeParagraph

'End With

' Insere o nome do autor no cabeçalho e formata
With Cabecintervalo
   .Text = vbNewLine & autor & vbNewLine
   .Font.Name = "Times New Roman"
   .Font.Size = 14
   .ParagraphFormat.Alignment = wdAlignParagraphCenter
End With

End Sub

Public Function OpenFileDialog() As String

    Dim Filter As String, Title As String
    Dim FilterIndex As Integer
    Dim FileName As Variant
    ' Define o filtro de procura dos arquivos
    Filter = "Arquivos Wave (*.wav),*.wav,"
    ' O filtro padrão é *.*
    FilterIndex = 3
    ' Define o Título (Caption) da Tela
    Title = "Selecione um arquivo"
    ' Define o disco de procura
    ChDrive ("C")
    ChDir ("C:\")
    With Application
        ' Abre a caixa de diálogo para seleção do arquivo com os parâmetros
        FileName = .GetOpenFilename(Filter, FilterIndex, Title)
        ' Reseta o Path
        ChDrive (Left(.DefaultFilePath, 1))
        ChDir (.DefaultFilePath)
    End With
    ' Abandona ao Cancelar
    If FileName = False Then
        MsgBox "Nenhum arquivo foi selecionado."
        Exit Function
    End If
    ' Retorna o caminho do arquivo
    OpenFileDialog = FileName
    
End Function
Sub Abre()
  
With Dialogs(wdDialogFileOpen)
 .Name = "*.*"
 .Show
End With

If Application.Documents.Count >= 2 Then
    'MsgBox ActiveDocument.Name
    z = ActiveDocument.Name
Else
    MsgBox "No documents are open"
    End
End If

End Sub
