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
            Text="Upload" Height="25px" onclick="Button1_Click" />
        <asp:Button ID="btnPush" runat="server" Text="Push" />
        <asp:Button ID="btnPull" runat="server" Text="Pull" />
        <asp:Button ID="btnConflict" runat="server" Text="Conflict" />
        <asp:Button ID="btnRepository" runat="server" Text="Repository" Width="76px" />
        <asp:Button ID="btnBranches" runat="server" Text="Branches" Width="77px" />
        <asp:Button ID="btnMerge" runat="server" Text="Merge" Width="50px" />
        <br />
        <br />
        Directory Tree<br />
        <%--        <asp:Button ID="Button2" runat="server" Text="Open repository" onclick="OnSelectRepository" />--%>
        <asp:ListBox ID="ListBox1" runat="server" BackColor="#FFFFCC" Width="217px">
        </asp:ListBox>
        <br />
        <br />
        Commit History - detail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        Commit History - simple (Author|DateCreated |Subject|Committer|DateCommitted)<br />
        <asp:ListBox ID="lstCommitHistory" runat="server" BackColor="#FFFFCC" 
            Width="472px"></asp:ListBox>
        <asp:ListBox ID="lstCommitHistorySimple" runat="server" BackColor="#FFFFCC" 
            Width="492px"></asp:ListBox>
        <br />
        <br />
        Branches<br />
        <asp:ListBox ID="lstBranches" runat="server" BackColor="#FFFFCC" 
            ForeColor="#3366CC" Width="217px"></asp:ListBox>
        <asp:Button ID="btnCheckout" runat="server" Text="Checkout" />
        <asp:Button ID="btnCheckin" runat="server" Text="Checkin" />
        <br />
        <br />
        Committed Changes but not merged<br />
        <asp:ListBox ID="lstCommittedNotMerged" runat="server" Width="404px">
        </asp:ListBox>

   </div>
    </form>
</body>
</html>
