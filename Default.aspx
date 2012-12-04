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
            height: 20px;
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
            width: 127px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="pnlGitCouch" runat="server" Width="115%" CssClass="txtbox" Font-Names="Calibri"
        Style="margin: 0 auto; padding: 0 auto" Height="5%">
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
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                        <asp:View ID="viewGitRepository" runat="server">
                            <br />
                            <table cellpadding="0" cellspacing="0" width="600px">
                                <tr valign="top">
                                    <td style="width: 600px; border: 1 thin blue;">
                                        <table style="width: 789px">
                                            <tr>
                                                <td class="style4">
                                                    <asp:TextBox ID="txtImport" runat="server" Width="311px">C:\Temp</asp:TextBox>
                                                    <%--                                                    <asp:FileUpload ID="FileUpload1" runat="server" Width="218px" />--%>
                                                    <asp:ImageButton ID="btnUploadManual" runat="server" ImageAlign="Middle" 
                                                        ImageUrl="~/images/Import.png" OnClick="btnUploadManual_Click" 
                                                        ToolTip="Import manual" Height="20px" Width="20px" />
                                                </td>
                                                <%--                                               <td>
                                                    Branches
                                                    <asp:DropDownList ID="lstBranches" runat="server" BackColor="#FFFFCC" 
                                                        CausesValidation="false" ForeColor="#3366CC">
                                                    </asp:DropDownList>
                                                </td>--%>
                                                <td class="style5">
                                                    <asp:ImageButton ID="btnPublishtoCouch" runat="server" Height="20px" 
                                                        ImageAlign="Middle" ImageUrl="~/images/Publish.png" 
                                                        onclick="btnPublishtoCouch_Click" ToolTip="Publish draft to Couch" 
                                                        Width="20px" />
                                                    &nbsp;<asp:ImageButton ID="btnDeleteCouchRows" runat="server" 
                                                        ImageAlign="Middle" ImageUrl="~/images/deletecouch.png" 
                                                        onclick="btnDeleteCouchRows_Click" ToolTip="Delete Couch rows" />
                                                </td>
                                                <td>
                                                    Users
                                                    <asp:DropDownList ID="lstUsers" runat="server" BackColor="#FFFFCC" 
                                                        CausesValidation="false" ForeColor="#3366CC">
                                                    </asp:DropDownList>
                                                    &nbsp;<asp:ImageButton ID="btnCheckoutByUser" runat="server" 
                                                        ImageUrl="~/images/checkout.png" onclick="btnCheckoutByUser_Click" 
                                                        ToolTip="Check out selected files" Height="20px" Width="20px" />
                                                    &nbsp;<asp:ImageButton ID="btnCheckinByUser" runat="server" 
                                                        ImageUrl="~/images/checkin.png" ToolTip=" Check in branch files" 
                                                        Height="20px" Width="20px" />
                                                    &nbsp;<asp:ImageButton ID="btnGitDraft" runat="server" ImageUrl="~/images/draft.png" 
                                                        onclick="btnGitDraft_Click" ToolTip="Create draft in GIT repository" 
                                                        Height="20px" Width="20px" />
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                        <table ID="Table1" runat="server">
                                            <tr>
                                                <td style="overflow: scroll; height: 200px" valign="top">
                                                    <asp:Panel ID="Panel1" runat="server" Height="467px" Width="395px">
                                                        Directory Tree<%--        <asp:Button ID="Button2" runat="server" Text="Open repository" onclick="OnSelectRepository" />--%><asp:TreeView 
                                                            ID="treeFiles" runat="server" EnableClientScript="false" ImageSet="Arrows" 
                                                            OnSelectedNodeChanged="treeFiles_SelectedNodeChanged" 
                                                            OnTreeNodeExpanded="NoLinkWhenExpanded" OnTreeNodePopulate="populate_gitDir" 
                                                            ShowLines="True" Width="322px" ShowCheckBoxes="Parent">
                                                            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                                                            <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" 
                                                                HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                                                            <ParentNodeStyle Font-Bold="False" />
                                                            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" 
                                                                HorizontalPadding="0px" VerticalPadding="0px" />
                                                        </asp:TreeView>
                                                    </asp:Panel>
                                                </td>
                                                <td class="style1" valign="top">
                                                    <table ID="tblXML" runat="server" border="1" visible="false">
                                                        <tr>
                                                            <td class="style2">
                                                                <asp:ImageButton ID="btnEditXML" runat="server" ImageAlign="Middle" 
                                                                    ImageUrl="~/images/Edit.png" onclick="btnEditXML_Click" 
                                                                    ToolTip="Edit XML Fragment" Height="20px" Width="20px" />
                                                                &nbsp;<asp:ImageButton ID="btnRefreshXML" runat="server" ImageAlign="Middle" 
                                                                    ImageUrl="~/images/refresh.png" onclick="btnRefreshXML_Click" 
                                                                    ToolTip="Refresh XML fragment" Width="20px" Height="20px" />
                                                                &nbsp;<asp:ImageButton ID="btnValidateXML" runat="server" ImageAlign="Middle" 
                                                                    ImageUrl="~/images/validate.png" onclick="btnValidateXML_Click" 
                                                                    ToolTip="Validate XML fragment" Height="20px" Width="20px" />
                                                                <%--<asp:Button ID="btnMergeXML" runat="server" OnClick="btnMergeXML_Click" 
                                                                    Text="Merge" Width="54px" />--%>
                                                                <asp:ImageButton ID="btnShowBlame" runat="server" ImageAlign="Middle" 
                                                                    ImageUrl="~/images/blame.png" OnClick="ImageButton1_Click1" 
                                                                    ToolTip="Blame - who created/modified the file" Height="20px" 
                                                                    Width="20px" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style3" valign="top">
                                                                <asp:Panel ID="Panel2" runat="server" Height="369px" Width="700px">
                                                                    <asp:Xml ID="Xml1" runat="server" DocumentSource="" EnableViewState="true" 
                                                                        TransformSource=""></asp:Xml>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <%--        <asp:ListBox ID="lstAll" runat="server" BackColor="#FFFFCC" 
            Width="751px" Height="230px"></asp:ListBox>
            </td>--%>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="viewGitCommands" runat="server">
                            <br />
                            <table cellpadding="0" cellspacing="0" width="600px">
                                <tr valign="top">
                                    <td style="width: 600px">
                                        <asp:ImageButton ID="btnCommitHistDetail" runat="server" ImageAlign="Middle" 
                                            ImageUrl="~/images/AllHistory.png" OnClick="btnCommitHistDetail_Click" 
                                            ToolTip="Commit History - detail" />
                                        &nbsp;<asp:ImageButton ID="btnCommitHistSimple" runat="server" ImageAlign="Middle" 
                                            ImageUrl="~/images/SimpleHistory.png" OnClick="btnCommitHistSimple_Click" 
                                            ToolTip="Commit History - Simple" />
                                        &nbsp;<asp:ImageButton ID="btnCommittedNotMerged" runat="server" ImageAlign="Middle" 
                                            ImageUrl="~/images/notMerged.png" OnClick="btnCommittedNotMerged_Click" 
                                            ToolTip="Committed not merged" />
                                        &nbsp;&nbsp;<asp:ImageButton ID="btnListAll" runat="server" ImageAlign="Middle" 
                                            ImageUrl="~/images/AllFiles.png" OnClick="btnListAll_Click" 
                                            ToolTip="List all files" />
                                        &nbsp;<asp:ImageButton ID="btnListbyAuthor" runat="server" ImageAlign="Middle" 
                                            ImageUrl="~/images/user.png" OnClick="btnListbyAuthor_Click" 
                                            Style="height: 16px" ToolTip="List by Author" />
                                        &nbsp;
                                        <asp:TextBox ID="txtSearchRepo" runat="server" Width="185px"></asp:TextBox>
                                        &nbsp;<asp:ImageButton ID="btnLookup" runat="server" ImageAlign="Middle" 
                                            ImageUrl="~/images/look.png" OnClick="btnLookup_Click" Style="width: 16px" 
                                            ToolTip="Find text in repository" />
                                        <asp:Label ID="lblGitCommand" runat="server" Font-Bold="True" Font-Size="Large" 
                                            ForeColor="#000099"></asp:Label>
                                        <br />
                                        <table>
                                            <tr>
                                                <td valign="top">
                                                    <asp:ListBox ID="lstAll" runat="server" BackColor="#FFFFCC" Height="371px" 
                                                        Style="overflow: auto" Width="1092px">
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
                            <table cellpadding="0" cellspacing="0" style="width: 600px;">
                                <tr style="vertical-align: top">
                                    <td style="width: 600px">
                                        <div>
                                            <%--<FTB:FreeTextBox id="FreeTextBox1" runat="Server"></FTB:FreeTextBox>--%>
                                            <asp:Button ID="btnCouchDraft" runat="server" onclick="btnCouchDraft_Click" 
                                                Text="QC Couch Draft" Width="103px" />
                                            <asp:Button ID="btnPush" runat="server" Text="Push" />
                                            <asp:Button ID="btnPull" runat="server" Text="Pull" />
                                            <asp:Button ID="btnCheckout" runat="server" Text="Checkout" Width="68px" />
                                            <asp:Button ID="btnCheckin" runat="server" Text="Checkin" Width="55px" />
                                            <asp:Button ID="btnRepository" runat="server" Text="Repository" Width="76px" />
                                            <asp:Button ID="btnCouch" runat="server" OnClick="btnCouch_Click" 
                                                Text="CouchIT" Width="67px" />
                                            <asp:ImageButton ID="btnCouchIT" runat="server" Height="23px" 
                                                ImageAlign="AbsMiddle" ImageUrl="~/images/couch.jpg" 
                                                OnClick="ImageButton1_Click" Width="42px" />
                                            <br />
                                            <asp:Label ID="lblCouchMsg" runat="server"></asp:Label>
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
                                            <%--        <asp:ListBox ID="lstBranches" runat="server" BackColor="#FFFFCC" 
            ForeColor="#3366CC" Width="401px" Height="83px" CausesValidation="false"></asp:ListBox>--%>
                                            <%--Committed Changes but not merged<br />
        <asp:ListBox ID="lstCommittedNotMerged" runat="server" Width="404px">
        </asp:ListBox>--%>         <table ID="Table2" runat="server">
                                            <tr>
                                                <td style="overflow: scroll; height: 200px" valign="top">
                                                    <asp:Panel ID="Panel3" runat="server" Height="467px" Width="395px">
                                                        <%--        <asp:Button ID="Button2" runat="server" Text="Open repository" onclick="OnSelectRepository" />--%><asp:TreeView 
                                                            ID="TreeView1" runat="server" EnableClientScript="false" ImageSet="Arrows" 
                                                            OnSelectedNodeChanged="treeFiles_SelectedNodeChanged" 
                                                            OnTreeNodeExpanded="NoLinkWhenExpanded" OnTreeNodePopulate="populate_gitDir" 
                                                            ShowLines="True" Width="322px" ShowCheckBoxes="Parent">
                                                            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                                                            <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" 
                                                                HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                                                            <ParentNodeStyle Font-Bold="False" />
                                                            <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" 
                                                                HorizontalPadding="0px" VerticalPadding="0px" />
                                                        </asp:TreeView>
                                                    </asp:Panel>
                                                </td>
                                                <td class="style1" valign="top">
                                                    <table ID="Table3" runat="server" border="1" visible="false">
                                                        <tr>
                                                            <td class="style3" valign="top">
                                                                <asp:Panel ID="Panel4" runat="server" Height="369px" Width="700px">
                                                                    <asp:Xml ID="Xml2" runat="server" DocumentSource="" EnableViewState="true" 
                                                                        TransformSource=""></asp:Xml>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <%--        <asp:ListBox ID="lstAll" runat="server" BackColor="#FFFFCC" 
            Width="751px" Height="230px"></asp:ListBox>
            </td>--%>
                                            </tr>
                                        </table>
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
