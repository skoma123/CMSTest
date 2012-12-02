<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" ValidateRequest="false"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

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
            height: 27px;
        }
        .style3
        {
            overflow: scroll;
            height: 200px;
            width: 559px;
        }
        .tabs
        {
            position: relative;
            top: 1px;
            left: 1px;
            height: 13px;
        }
        .tab
        {
            border: solid 1px black;
            background-color: white;
            padding: 2px 10px;
        }
        .selectedTab
        {
            background-color: Navy;
            border-bottom: solid 1px white;
        }
        .tabContents
        {
            border: solid 1px black;
            padding: 10px;
            background-color: white;
            color: Black;
        }
        #tblXML
        {
            height: 430px;
        }
        .style4
        {
            width: 350px;
        }
        .style5
        {
            width: 72px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="pnlGitCouch" runat="server" Width="98%" CssClass="txtbox" Font-Names="Calibri"
        Style="margin: 0 auto; padding: 0 auto" Height="10%">
        <table id="tblMenu" runat="server" style="vertical-align: top; width: 750px;">
            <tr>
                <td>
                    <asp:Menu ID="mnuGitCouch" Width="120px" runat="server" Orientation="Horizontal"
                        StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selectedTab"
                        CssClass="tabs" StaticEnableDefaultPopOutImage="False" OnMenuItemClick="Menu1_MenuItemClick">
                        <StaticSelectedStyle CssClass="selectedTab"></StaticSelectedStyle>
                        <StaticMenuItemStyle CssClass="tab"></StaticMenuItemStyle>
                        <Items>
                            <asp:MenuItem Text="Git Repository" Value="0" Selected="true"></asp:MenuItem>
                            <asp:MenuItem Text="Git Extensions" Value="1"></asp:MenuItem>
                            <asp:MenuItem Text="Couch" Value="2"></asp:MenuItem>
                        </Items>
                    </asp:Menu>
                    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                        <asp:View ID="viewGitRepository" runat="server">
                            <br />
                            <table width="600px" cellpadding="0" cellspacing="0">
                                <tr valign="top">
                                    <td style="width: 600px; border: 1 thin blue;">
                                        <table style="width: 789px">
                                            <tr>
                                                <td class="style4">
                                                    <asp:TextBox ID="txtImport" runat="server" Width="311px">C:\Temp</asp:TextBox>
                                                    <%--                                                    <asp:FileUpload ID="FileUpload1" runat="server" Width="218px" />--%>
                                                    <asp:ImageButton ID="btnUploadManual" runat="server" ImageAlign="Middle" ImageUrl="~/images/upload.png"
                                                        OnClick="btnUploadManual_Click" ToolTip="Import" />
                                                </td>
                                                <%--                                               <td>
                                                    Branches
                                                    <asp:DropDownList ID="lstBranches" runat="server" BackColor="#FFFFCC" 
                                                        CausesValidation="false" ForeColor="#3366CC">
                                                    </asp:DropDownList>
                                                </td>--%>
                                                <td class="style5"><asp:Button ID="btnPublish" runat="server" Text="Publish" /></td>                                                
                                                <td>
                                                    Users
                                                    <asp:DropDownList ID="lstUsers" runat="server" BackColor="#FFFFCC" CausesValidation="false"
                                                        ForeColor="#3366CC">
                                                    </asp:DropDownList>
                                                </td>
                                                <td><asp:Button ID="btnCheckOutBranch" runat="server" Text="Checkout" /></td>
                                            </tr>
                                        </table>
                                        <table id="Table1" runat="server">
                                            <tr>
                                                <td valign="top" style="overflow: scroll; height: 200px">
                                                    <asp:Panel ID="Panel1" runat="server" Height="467px" Width="395px">
                                                        Directory Tree<%--        <asp:Button ID="Button2" runat="server" Text="Open repository" onclick="OnSelectRepository" />--%><asp:TreeView
                                                            ID="treeFiles" runat="server" OnTreeNodePopulate="populate_gitDir" EnableClientScript="false"
                                                            ImageSet="Arrows" OnSelectedNodeChanged="treeFiles_SelectedNodeChanged" OnTreeNodeExpanded="NoLinkWhenExpanded"
                                                            ShowLines="True" Width="322px">
                                                            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                                                            <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px"
                                                                NodeSpacing="0px" VerticalPadding="0px" />
                                                            <ParentNodeStyle Font-Bold="False" />
                                                            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"
                                                                VerticalPadding="0px" />
                                                        </asp:TreeView>
                                                    </asp:Panel>
                                                </td>
                                                <td valign="top" class="style1">
                                                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                                    <table id="tblXML" runat="server" border="1" visible="false">
                                                        <tr>
                                                            <td class="style2">
                                                                <asp:Button ID="btnEditXML" CausesValidation="false" runat="server" Text="Edit" OnClick="EditXMLWindow" />
                                                                <asp:Button ID="btnRefreshXML" runat="server" OnClick="btnRefreshXML_Click" Text="Refresh"
                                                                    Width="59px" />
                                                                <asp:Button ID="btnValidateXML" runat="server" Text="Validate" Width="59px" OnClick="btnValidateXML_Click" />
                                                                <asp:Button ID="btnMergeXML" runat="server" OnClick="btnMergeXML_Click" Text="Merge"
                                                                    Width="54px" />
                                                                <asp:ImageButton ID="btnShowBlame" runat="server" ImageAlign="Middle" ImageUrl="~/images/blame.png"
                                                                    OnClick="ImageButton1_Click1" ToolTip="Blame - who created/modified the file" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top" class="style3">
                                                                <asp:Panel ID="Panel2" runat="server" Height="369px" Width="700px">
                                                                    <asp:Xml ID="Xml1" runat="server" EnableViewState="true" DocumentSource="" TransformSource="~/CMS/MEL/747/Working/melcdl2html_mod.xsl"></asp:Xml></asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <%--        <asp:ListBox ID="lstAll" runat="server" BackColor="#FFFFCC" 
            Width="751px" Height="230px"></asp:ListBox>
            </td>--%></tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="viewGitCommands" runat="server">
                            <br />
                            <table width="600px" cellpadding="0" cellspacing="0">
                                <tr valign="top">
                                    <td style="width: 600px">
                                        <asp:ImageButton ID="btnCommitHistDetail" runat="server" ImageAlign="Middle" ImageUrl="~/images/AllHistory.png"
                                            OnClick="btnCommitHistDetail_Click" ToolTip="Commit History - detail" />
                                        &nbsp;<asp:ImageButton ID="btnCommitHistSimple" runat="server" ImageAlign="Middle"
                                            ImageUrl="~/images/SimpleHistory.png" OnClick="btnCommitHistSimple_Click" ToolTip="Commit History - Simple" />
                                        &nbsp;<asp:ImageButton ID="btnCommittedNotMerged" runat="server" ImageAlign="Middle"
                                            ImageUrl="~/images/notMerged.png" OnClick="btnCommittedNotMerged_Click" ToolTip="Committed not merged" />
                                        &nbsp;&nbsp;<asp:ImageButton ID="btnListAll" runat="server" ImageAlign="Middle" ImageUrl="~/images/AllFiles.png"
                                            OnClick="btnListAll_Click" ToolTip="List all files" />
                                        &nbsp;<asp:ImageButton ID="btnListbyAuthor" runat="server" ImageAlign="Middle" ImageUrl="~/images/user.png"
                                            OnClick="btnListbyAuthor_Click" Style="height: 16px" ToolTip="List by Author" />
                                        &nbsp;
                                        <asp:TextBox ID="txtSearchRepo" runat="server" Width="185px"></asp:TextBox>
                                        &nbsp;<asp:ImageButton ID="btnLookup" runat="server" ImageAlign="Middle" ImageUrl="~/images/look.png"
                                            OnClick="btnLookup_Click" Style="width: 16px" ToolTip="Find text in repository" />
                                        <asp:Label ID="lblGitCommand" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="#000099"></asp:Label>
                                        <br />
                                        <table>
                                            <tr>
                                                <td valign="top">
                                                    <asp:ListBox Style="overflow: auto" ID="lstAll" runat="server" BackColor="#FFFFCC"
                                                        Width="1092px" Height="275px"
                                                       > <%-- AutoPostBack="true" OnSelectedIndexChanged="lstAll_SelectedIndexChanged"--%>
                                                    </asp:ListBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="viewCouch" runat="server">
                            <br />
                            <table style="width: 600px;" cellpadding="0" cellspacing="0">
                                <tr style="vertical-align: top">
                                    <td style="width: 600px">
                                        <div>
                                            <%--<FTB:FreeTextBox id="FreeTextBox1" runat="Server"></FTB:FreeTextBox>--%>
                                            <asp:Button ID="btnPush" runat="server" Text="Push" />
                                            <asp:Button ID="btnPull" runat="server" Text="Pull" />
                                            <asp:Button ID="btnCheckout" runat="server" Text="Checkout" Width="68px" />
                                            <asp:Button ID="btnCheckin" runat="server" Text="Checkin" Width="55px" />
                                            <asp:Button ID="btnConflict" runat="server" Text="Conflict" OnClick="btnConflict_Click" />
                                            <asp:Button ID="btnRepository" runat="server" Text="Repository" Width="76px" />
                                            <asp:Button ID="btnBranches" runat="server" Text="Branches" Width="77px" />
                                            <asp:Button ID="btnStage" runat="server" Text="Stage" Width="50px" OnClick="btnStage_Click" />
                                            <asp:Button ID="btnCouch" runat="server" Text="CouchIT" Width="67px" OnClick="btnCouch_Click" />
                                            <asp:ImageButton ID="btnCouchIT" runat="server" Height="23px" ImageAlign="AbsMiddle"
                                                ImageUrl="~/images/couch.jpg" OnClick="ImageButton1_Click" Width="42px" />
                                            <br />
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
                                            <br />
                                            <%--        <asp:ListBox ID="lstBranches" runat="server" BackColor="#FFFFCC" 
            ForeColor="#3366CC" Width="401px" Height="83px" CausesValidation="false"></asp:ListBox>--%>
                                            <%--Committed Changes but not merged<br />
        <asp:ListBox ID="lstCommittedNotMerged" runat="server" Width="404px">
        </asp:ListBox>--%>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                    </asp:MultiView>
                </td>
            </tr>
        </table>
    </asp:Panel>
    </form>
</body>
</html>
