<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 718px;
        }
        .style2
        {
            width: 559px;
        }
        .style3
        {
            overflow: scroll;
            height: 200px;
            width: 559px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div><%--<FTB:FreeTextBox id="FreeTextBox1" runat="Server"></FTB:FreeTextBox>--%>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:ImageButton ID="btnUploadManual" runat="server" ImageAlign="Middle" 
                ImageUrl="~/images/upload.png" onclick="btnUploadManual_Click" />
               <asp:Button ID="btnPush" runat="server" Text="Push" />
        <asp:Button ID="btnPull" runat="server" Text="Pull" />
        <asp:Button ID="btnCheckout" runat="server" Text="Checkout" Width="68px" />
        <asp:Button ID="btnCheckin" runat="server" Text="Checkin" Width="55px" />
        <asp:Button ID="btnConflict" runat="server" Text="Conflict" 
        onclick="btnConflict_Click" />
        <asp:Button ID="btnRepository" runat="server" Text="Repository" Width="76px" />
        <asp:Button ID="btnBranches" runat="server" Text="Branches" Width="77px" />
        <asp:Button ID="btnStage" runat="server" Text="Stage" Width="50px" 
            onclick="btnStage_Click" />
        <asp:Button ID="btnCouch" runat="server" Text="CouchIT" Width="67px" 
            onclick="btnCouch_Click" />
        <asp:ImageButton ID="btnCouchIT" runat="server" Height="23px" 
            ImageAlign="AbsMiddle" ImageUrl="~/images/couch.jpg" 
            onclick="ImageButton1_Click" Width="42px" />
        <br />
        <table runat="server"><tr>
        <td valign="top" style="overflow:scroll; height:200px">
        <asp:Panel runat="server" Height="200px" Width="395px" >
        Directory Tree<%--        <asp:Button ID="Button2" runat="server" Text="Open repository" onclick="OnSelectRepository" />--%><asp:TreeView
            ID="treeFiles" runat="server" OnTreeNodePopulate="populate_gitDir" EnableClientScript="false"
            ImageSet="Arrows" onselectednodechanged="treeFiles_SelectedNodeChanged" OnTreeNodeExpanded="NoLinkWhenExpanded" 
            ShowLines="True" Width="322px"  >
            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
            <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" 
                HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
            <ParentNodeStyle Font-Bold="False"  />
            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px" VerticalPadding="0px" />
        </asp:TreeView></asp:Panel>
        </td><td valign="top" class="style1">
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
            
            <table id="tblXML" runat="server" border="1" visible="false">
            <tr><td class="style2"><asp:Button ID="btnEditXML" CausesValidation="false" runat="server" Text="Edit" OnClick="EditXMLWindow" />
                <asp:Button ID="btnRefreshXML" runat="server" onclick="btnRefreshXML_Click" 
                    Text="Refresh" Width="59px" />
                <asp:Button ID="btnValidateXML" runat="server" Text="Validate" Width="59px" 
                    onclick="btnValidateXML_Click" />
                <asp:Button ID="btnMergeXML" runat="server" onclick="btnMergeXML_Click" 
                    Text="Merge" Width="54px" />
                <asp:ImageButton ID="btnShowBlame" runat="server" ImageAlign="Middle" 
                    ImageUrl="~/images/blame.png" onclick="ImageButton1_Click1" 
                    ToolTip="Blame - who created/modified the file" />
                </td></tr>                
            <tr><td  valign="top" class="style3"><asp:Panel ID="Panel1" runat="server" 
                    Height="200px" Width="700px"><asp:Xml ID="Xml1" runat="server" EnableViewState="true"
            DocumentSource="" 
            TransformSource="~/CMS/MEL/747/Working/melcdl2html_mod.xsl"></asp:Xml></asp:Panel></td></tr></table>
            </td>
 <%--        <asp:ListBox ID="lstAll" runat="server" BackColor="#FFFFCC" 
            Width="751px" Height="230px"></asp:ListBox>
            </td>--%></tr>
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
        <br />--%>
        <table><tr><td>Branches</td><td>Users</td></tr>
        <tr><td><asp:DropDownList ID="lstBranches" runat="server" BackColor="#FFFFCC" CausesValidation="false" ForeColor="#3366CC">
            </asp:DropDownList></td><td><asp:DropDownList ID="lstUsers" runat="server" BackColor="#FFFFCC" CausesValidation="false" ForeColor="#3366CC">
            </asp:DropDownList></td></tr></table>
            
            <%--        <asp:ListBox ID="lstBranches" runat="server" BackColor="#FFFFCC" 
            ForeColor="#3366CC" Width="401px" Height="83px" CausesValidation="false"></asp:ListBox>--%>
            <asp:ImageButton ID="btnCommitHistDetail" runat="server" ImageAlign="Middle" 
                ImageUrl="~/images/AllHistory.png" onclick="btnCommitHistDetail_Click" 
                ToolTip="Commit History - detail" />
        &nbsp;<asp:ImageButton ID="btnCommitHistSimple" runat="server" ImageAlign="Middle" 
                ImageUrl="~/images/SimpleHistory.png" onclick="btnCommitHistSimple_Click" 
                ToolTip="Commit History - Simple" />
&nbsp;<asp:ImageButton ID="btnCommittedNotMerged" runat="server" ImageAlign="Middle" 
                ImageUrl="~/images/notMerged.png" onclick="btnCommittedNotMerged_Click" 
                ToolTip="Committed not merged" />
        &nbsp;<asp:ImageButton ID="btnLookup" runat="server" ImageAlign="Middle" 
            ImageUrl="~/images/look.png" onclick="btnLookup_Click" 
        style="width: 16px" ToolTip="Find text in repository" />
        &nbsp;<br />
        <table><tr><td valign="top">
        <asp:ListBox  style="overflow:auto" ID="lstAll" runat="server" BackColor="#FFFFCC" 
            Width="1092px" Height="176px" ></asp:ListBox>
            </td></tr></table>
            <%--Committed Changes but not merged<br />
        <asp:ListBox ID="lstCommittedNotMerged" runat="server" Width="404px">
        </asp:ListBox>--%>
    

   </div>
    </form>
</body>
</html>
