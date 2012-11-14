<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>

<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="btnCommitHistory" runat="server" 
            onclick="btnCommitHistory_Click" Text="CommitHistDetail" Width="115px" 
            CausesValidation="false" />
        <asp:Button ID="btnCommitHistSimple" runat="server" 
            onclick="btnCommitHistSimple_Click" Text="CommitHistSimple" Width="130px" 
            CausesValidation="false" />
        <asp:Button ID="btnCommitNotMerged" runat="server" 
            onclick="btnCommitNotMerged_Click" Text="CommittedNotMerged" Width="149px" 
            CausesValidation="false" />
               <asp:Button ID="btnPush" runat="server" Text="Push" />
        <asp:Button ID="btnPull" runat="server" Text="Pull" />
        <asp:Button ID="btnConflict" runat="server" Text="Conflict" />
        <asp:Button ID="btnRepository" runat="server" Text="Repository" Width="76px" />
        <asp:Button ID="btnBranches" runat="server" Text="Branches" Width="77px" />
        <asp:Button ID="btnStage" runat="server" Text="Stage" Width="50px" />
        <br />
        <table runat="server"><tr>
        <td valign="top" style="overflow:scroll; height:200px">
        <asp:Panel runat="server" Height="200px" Width="395px">
        Directory Tree<%--        <asp:Button ID="Button2" runat="server" Text="Open repository" onclick="OnSelectRepository" />--%><asp:TreeView
            ID="treeFiles" runat="server" OnTreeNodePopulate="populate_gitDir" EnableClientScript="false"
            ImageSet="Arrows" onselectednodechanged="treeFiles_SelectedNodeChanged" OnTreeNodeExpanded="colorIt"
            ShowLines="True" Width="322px" >
            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
            <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" 
                HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
            <ParentNodeStyle Font-Bold="False"  />
            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px" VerticalPadding="0px" />
        </asp:TreeView></asp:Panel>
        </td><td valign="top">
        <asp:ListBox ID="lstAll" runat="server" BackColor="#FFFFCC" 
            Width="751px" Height="230px"></asp:ListBox>
            </td></tr>
        </table>
        
<%--    <br />
        <br />
        Commit History - detail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        Commit History - simple (Author|DateCreated |Subject|Committer|DateCommitted)<br />
        <asp:ListBox ID="lstCommitHistory" runat="server" BackColor="#FFFFCC" 
            Width="472px"></asp:ListBox>
        <asp:ListBox ID="lstCommitHistorySimple" runat="server" BackColor="#FFFFCC" 
            Width="492px"></asp:ListBox>
        <br />
        <br />--%>Branches<br />
        <asp:ListBox ID="lstBranches" runat="server" BackColor="#FFFFCC" 
            ForeColor="#3366CC" Width="401px" Height="83px"></asp:ListBox>
        <asp:Button ID="btnCheckout" runat="server" Text="Checkout" />
        <asp:Button ID="btnCheckin" runat="server" Text="Checkin" />
        <br />
        <br />
        <%--Committed Changes but not merged<br />
        <asp:ListBox ID="lstCommittedNotMerged" runat="server" Width="404px">
        </asp:ListBox>--%>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
        <br />
            
            <table id="tblXML" runat="server" border="1" visible="false">
            <tr><td><asp:Button ID="btnEditXML" CausesValidation="false" runat="server" Text="Edit" OnClick="EditXMLWindow" />
                <asp:Button ID="btnRefreshXML" runat="server" onclick="btnRefreshXML_Click" 
                    Text="Refresh" Width="59px" />
                <asp:Button ID="btnValidateXML" runat="server" Text="Validate" Width="59px" 
                    onclick="btnValidateXML_Click" />
                <asp:Button ID="btnMergeXML" runat="server" onclick="btnMergeXML_Click" 
                    Text="Merge" Width="54px" />
                <asp:Button ID="btnBlame" runat="server" onclick="btnBlame_Click" Text="Blame" 
                    Width="51px" />
                </td></tr>                
            <tr><td><asp:Xml ID="Xml1" runat="server" EnableViewState="true"
            DocumentSource="" 
            TransformSource="~/CMS/MEL/747/Working/melcdl2html_mod.xsl"></asp:Xml></td></tr></table>

        <br />

   </div>
    </form>
</body>
</html>
