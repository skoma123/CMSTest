<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:FileUpload ID="FileUpload1" runat="server" Width="594px" />
        <asp:Button ID="Button1" runat="server"
            Text="Upload" Height="20px" onclick="Button1_Click" />
        <br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server" Width="427px"></asp:TextBox>
        <asp:Button ID="Button2" runat="server" Text="Open repository" onclick="OnSelectRepository" />

   </div>
    </form>
</body>
</html>
