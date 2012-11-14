using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GitSharp;
using System.Diagnostics;
using System.IO;
using System.Text;
using MongoDB.Bson;
using MongoDB;
using System.Xml;
using System.Xml.Schema;
using System.Xml.XPath;
using System.Drawing;

public partial class _Default : System.Web.UI.Page 
{

    private StringBuilder _builder = new StringBuilder(); 
    
    ProcessStartInfo gitInfo = new ProcessStartInfo();
    string stdout_str;
    string[] words;
    Process gitProcess;
    private static bool isValid = true;
   // bool treepopu = false;
        //public const string CURRENT_REPOSITORY = "repository";

	
        //Repository m_repository;

        //private void OnLoadRepository(object sender, EventArgs e)
        //{
        //    LoadRepository(FileUpload1.FileName.ToString());
        //}

        //private void LoadRepository(string url)
        //{
        //    var git_url = Repository.FindRepository(url);
        //    if (git_url == null || !Repository.IsValid(git_url))
        //    {
        //                        return;
        //    }
        //    var repo = new Repository(git_url);
        //    //UserSettings.SetValue(CURRENT_REPOSITORY, git_url);
        //    var head = repo.Head.Target as Commit;
        //    Debug.Assert(head != null);
        //    m_repository = repo;

        //}

        //public void OnSelectRepository(object sender, EventArgs e)
        //{
        //    //var dlg = new System.Windows.Forms.FolderBrowserDialog();
        //    //dlg.SelectedPath = Path.GetDirectoryName(UserSettings.GetString(CURRENT_REPOSITORY));
        //    //if (dlg.ShowDialog() == System.Windows.Forms.DialogResult.OK)
        //    //{
        //    //    m_url_textbox.Text = dlg.SelectedPath;
        //    LoadRepository(TextBox1.Text);

        //    Repository repo = new Repository(TextBox1.Text);

        //    //Get the current branch
        //    var branch = repo.CurrentBranch;
        //    Console.WriteLine("Current branch is " + branch.Name);



        //    //}
        //}


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Response.Write("<script>alert('Again')</script>");
            gitInfo.CreateNoWindow = true;
            gitInfo.RedirectStandardError = true;
            gitInfo.RedirectStandardOutput = true;
            gitInfo.UseShellExecute = false;
            gitInfo.FileName = @"C:\Program Files\Git" + @"\bin\git.exe";

            //git processes to run
            gitProcess = new Process();
            gitInfo.WorkingDirectory = @"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP"; //"D:\data\FileShareGITsample\"; //YOUR_GIT_REPOSITORY_PATH;

            BindTreeView();

            gitInfo.Arguments = "branch -a"; // such as "fetch orign" //GIT COMMAND
            gitProcess.StartInfo = gitInfo;
            gitProcess.Start();

            //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
            stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

            //clear the listbox
            lstBranches.Items.Clear();
            words = stdout_str.Split('\n');

            foreach (string strtest in words)
                if (strtest != "") {
                    lstBranches.Items.Add(strtest.Trim());
                    if (strtest.Contains("*"))
                        lstBranches.SelectedValue = strtest;
                }
                   
        }
        else
        {
            if (treeFiles.SelectedValue != null)
            {
                Xml1.DocumentSource = treeFiles.SelectedValue;
            }
        }

    }

    protected void BindTreeView()
    {
        DirectoryInfo dir1 = new DirectoryInfo(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\");
        treeFiles.Nodes.Add(GetNode(dir1));
    }

    protected TreeNode GetNode(DirectoryInfo directoryinfo)
    {
        TreeNode treenode = new TreeNode(directoryinfo.Name, directoryinfo.FullName);
        treenode.PopulateOnDemand = true;
        treenode.Collapse();

        return treenode;
    }

    protected TreeNode GetNodeFiles(FileInfo fileinfo)
    {
        TreeNode treenode = new TreeNode(fileinfo.Name, fileinfo.FullName);
        if (treenode.ChildNodes.Count != 0)
        {
        treenode.SelectAction = TreeNodeSelectAction.None;
        treenode.PopulateOnDemand = true;
        treenode.Collapse();
        }
        else
        {
            treenode.SelectAction = TreeNodeSelectAction.Select;
            treenode.PopulateOnDemand = false;
            treenode.Expanded = false;  //.Depth = 0; //.Expand();
        }
        return treenode;
    }

    protected void populate_gitDir(object sender, TreeNodeEventArgs e)
    {
        try
        {

            {
                //if (treepopu == false)

                    // if (treeFiles.Nodes.Count > 1)
                    // {
                    DirectoryInfo dirInfo1 = new DirectoryInfo(e.Node.Value);
                    foreach (DirectoryInfo dirinfo in dirInfo1.GetDirectories())
                        e.Node.ChildNodes.Add(GetNode(dirinfo));
                    foreach (FileInfo fileinfo in dirInfo1.GetFiles())
                        e.Node.ChildNodes.Add(GetNodeFiles(fileinfo));
                    // }
               // }
            }
        }

        catch
        {
            throw;    // Rethrowing exception e
        }


    }

  /*  protected void Button1_Click(object sender, EventArgs e)
    {
        //Opening an existing git repository
        Repository repo = new Repository(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP");
    } */

      //  gitInfo.Arguments = "ls-files"; // such as "fetch orign" //GIT COMMAND
      //  gitProcess.StartInfo = gitInfo;
      //  gitProcess.Start();

      //  //list files git ls-files

      ////  string stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
      //  string stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT
      //  ListBox1.Items.Clear();
      //  string[] words = stdout_str.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
      //  foreach (string strtest in words)
      //      if (strtest != "")
      //          ListBox1.Items.Add(strtest);

        ////Root 
        ////Get the root tree of the most recent commit
        //var tree = repo.Head.CurrentCommit.Tree;
        ////Now you can browse throught that tree by iterating over its child trees
        //foreach (Tree subtree in tree.Trees)
        //    ListBox1.Items.Add(subtree.Path);

        ////Or printing the names of the files it contains
        //foreach (Leaf leaf in tree.Leaves)
        //    ListBox1.Items.Add(leaf.Name);
        //   // Console.WriteLine(leaf.Path);
        
   

       //// //commit history (authorname, author date, subject, committer name, committed date)
       //// gitInfo.Arguments = @"log --pretty=format:""%an | %ar | %s | %cn | %cr"""; //"log --pretty=oneline"; // "log --stat"; // such as "fetch orign" //GIT COMMAND
       //// gitProcess.StartInfo = gitInfo;
       //// gitProcess.Start();

       //// //git log -p -2 difference introduced in each commit

       //// //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
       //// stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

       //// lstCommitHistorySimple.Items.Clear();
       //// words = stdout_str.Split('\n');

       ////foreach (string strtest in words)
       ////     if (strtest != "")
       ////         //lstCommitHistorySimple.Items.Add(strtest);
       ////         lstCommitHistorySimple.Items.Add(strtest);
       //////commit history
       ////gitInfo.Arguments = "log --stat"; // such as "fetch orign" //GIT COMMAND
       ////gitProcess.StartInfo = gitInfo;
       ////gitProcess.Start();

       //////git log -p -2 difference introduced in each commit

       //////stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
       ////stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

       ////lstCommitHistory.Items.Clear();
       ////words = stdout_str.Split('\n');

       ////foreach (string strtest in words)
       ////    if (strtest != "")
       ////        lstCommitHistory.Items.Add(strtest);

       //list of commits made in last 2 weeks "log --since=2.weeks"
       //last commit This seems a bit clearer. It’s also common to add a last command, like this: $ git config --global alias.last 'log -1 HEAD'
       //This way, you can see the last commit easily: $ git last

        //gitInfo.Arguments = @"log --pretty=""%h - %s"" --author=skoma123 --graph --decorate --all --since=""2012-10-01"" --before=""2012-11-01"" --no-merges"; //"log --pretty=oneline"; // "log --stat"; // such as "fetch orign" //GIT COMMAND
        //gitProcess.StartInfo = gitInfo;
        //gitProcess.Start();

        ////stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        //stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        //lstCommittedNotMerged.Items.Clear();
        //words = stdout_str.Split('\n');

        //foreach (string strtest in words)
        //    if (strtest != "")
        //        lstCommittedNotMerged.Items.Add(strtest);

        //gitProcess.WaitForExit();
        //gitProcess.Close();

        //***********see changes 10 revisions back on a single file or entire tree
       // # 10 single file foo.c-changes ago **** git show $(git rev-list -n 10 --reverse HEAD -- readme3.c | head -1):readme3.c
       //whole tree 10 changes ago 
       //what changed in the last 3 commits ****git whatchanged -3
       //git gui **gitk -all
       //decorate the tree display ** git log --pretty=oneline --graph --decorate --all

       // # 10 whole-tree-changes ago ***git show HEAD~10:foo.c

        //edit commmit msg of most recent commit ** git commit --amend

//1.git diff - shows the differences between the last checked in version and files that have been changed, but not had git add run on them.
//2.git diff --cached - shows the differences between the previous version and what all files that have had git add run, but have not been committed
//3.git diff commitid - show the differences between the current working directory and a previous commit as specified with the commitid
//4.git diff commita..commitb - shows the differences between two commits, a and b. The commits could also be symbolic names like branches or tags.


//If it is one (single) branch that you need to check, for example if you want that branch 'B' is fully merged into branch 'A', you can simply do the following:

//$ git checkout A
//$ git branch -d B
//git branch -d <branchname> has the safety that "The branch must be fully merged in HEAD."
        //commits that are not merged
        //git branch --no-merged CMS

  //      git status
  //show files added to the staging area, files with changes, and untracked files

  //      git diff
  //show a diff of the changes made since your last commit

  //      git commit --amend
  //edit the commit message of the most recent commit


        //Add a new folder with subfolder 747 copy and paste from another location.
        //***************STAGE, COMMIT with comment **git stage CMS/MEL/*.* // **git commit -am "my commit message"
        //***PUSH to remote location ****git push

        //


    protected void colorIt(object sender, TreeNodeEventArgs e)
    {
       e.Node.SelectAction = TreeNodeSelectAction.None;
       lblMsg.Text = "You selected";

    }
    protected void treeFiles_SelectedNodeChanged(object sender, EventArgs e)
    {
        try
        {
           
           Xml1.DocumentSource = treeFiles.SelectedValue;
        //   Xml1.TransformSource = "~/CMS/MEL/747/melcdl2html_mod.xsl";
          treeFiles.SelectedNodeStyle.ForeColor = Color.Blue;
           tblXML.Visible = true;

        }           
        catch
        {
            throw;    // Rethrowing exception e
        }
    }
    protected void InitialProcessing()
    {
        //Response.Write("<script>alert('Again')</script>");
        gitInfo.CreateNoWindow = true;
        gitInfo.RedirectStandardError = true;
        gitInfo.RedirectStandardOutput = true;
        gitInfo.UseShellExecute = false;
        gitInfo.FileName = @"C:\Program Files\Git" + @"\bin\git.exe";

        //git processes to run
        gitProcess = new Process();
        gitInfo.WorkingDirectory = @"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP"; //"D:\data\FileShareGITsample\"; //YOUR_GIT_REPOSITORY_PATH;

    }

    protected void btnCommitHistory_Click(object sender, EventArgs e)
    {
        lstAll.Items.Clear();
        InitialProcessing();
        gitInfo.Arguments = "log --stat"; // such as "fetch orign" //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //git log -p -2 difference introduced in each commit

        //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                lstAll.Items.Add(strtest);
    }
    protected void btnCommitHistSimple_Click(object sender, EventArgs e)
    {
        lstAll.Items.Clear();
        InitialProcessing();
        //commit history (authorname, author date, subject, committer name, committed date)
        gitInfo.Arguments = @"log --pretty=format:""%an | %ar | %s | %cn | %cr"""; //"log --pretty=oneline"; // "log --stat"; // such as "fetch orign" //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //git log -p -2 difference introduced in each commit

        //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                //lstCommitHistorySimple.Items.Add(strtest);
                lstAll.Items.Add(strtest);
    }
    protected void btnCommitNotMerged_Click(object sender, EventArgs e)
    {
        lstAll.Items.Clear();
        InitialProcessing();
        gitInfo.Arguments = @"log --pretty=""%h - %s"" --author=skoma123 --graph --decorate --all --since=""2012-10-01"" --before=""2012-11-30"" --no-merges"; //"log --pretty=oneline"; // "log --stat"; // such as "fetch orign" //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                lstAll.Items.Add(strtest);

        gitProcess.WaitForExit();
        gitProcess.Close();
    }

    protected void EditXMLWindow(object sender, EventArgs e)
    {
        
        System.Diagnostics.Process.Start(@treeFiles.SelectedValue);
       
    }
    protected void btnRefreshXML_Click(object sender, EventArgs e)
    {
        InitialProcessing();
        gitInfo.Arguments = @"stage CMS\MEL\*.*"; //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        gitInfo.Arguments = @"commit -am ""Updated XML file"""; //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();


        gitInfo.Arguments = @"push"; //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        gitProcess.WaitForExit();
        gitProcess.Close();

        Xml1.DocumentSource = treeFiles.SelectedValue;
    }
    protected void btnMergeXML_Click(object sender, EventArgs e)
    {
        InitialProcessing();
        gitInfo.Arguments = @"merge CMS"; //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();   

        gitProcess.WaitForExit();
        gitProcess.Close();
    }
    protected void btnBlame_Click(object sender, EventArgs e)
    {
        InitialProcessing();
        gitInfo.Arguments = @"blame CMS/MEL/747/" + @treeFiles.SelectedNode.Text;
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();   

        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        lstAll.Items.Clear();
        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                lstAll.Items.Add(strtest);

        gitProcess.WaitForExit();
        gitProcess.Close();
    }

    protected void btnValidateXML_Click(object sender, EventArgs e)
    {
        try
        {
            string xmlPath = treeFiles.SelectedValue.Replace("\\", "/");
            XmlReader reader = null;
            XmlReaderSettings settings = new XmlReaderSettings();
            settings.ValidationEventHandler += new ValidationEventHandler(MyValidationEventHandler);
            settings.ValidationType = ValidationType.DTD;
            settings.ProhibitDtd = false;
            reader = XmlReader.Create(xmlPath, settings);
            if (reader.Read())
            {
                //Response.Write("<script>alert('XML Document well formed')</script>");
                lblMsg.Text = "XML Document well formed";
                lblMsg.ForeColor = Color.Green;
            }
            else
            {
                lblMsg.Text = "XML Document is not well formed";
                lblMsg.ForeColor = Color.Red;
            }
            while (reader.Read())
            {
            }

            if (_builder.ToString() == String.Empty)
                lblMsg.Text = "DTD Validation completed successfully";
            //Response.Write("<script>alert('DTD Validation completed successfully')</script>");
            //Response.Write("DTD Validation completed successfully.");
            else
                lblMsg.Text = "DTD Validation Failed";
            //Response.Write("<script>alert('DTD Validation Failed" + _builder.ToString() + "')</script>");
            // Response.Write("DTD Validation Failed. <br>" + _builder.ToString());
            reader.Close();

        }
        catch (XmlException ex)
        {
              lblMsg.Text = "XML Document not valid, following error:" +  ex.Message;          
              Server.ClearError();
              Xml1.DocumentSource = treeFiles.SelectedValue;
                             
             }
    }

       // XmlTextReader r = new XmlTextReader(treeFiles.SelectedValue);
       // XmlReader v = new XmlReader;

       // v.ValidationType = ValidationType.DTD;

       // v.ValidationEventHandler += new ValidationEventHandler(MyValidationEventHandler);


       // while (v.Read())
       // {
       //     // Can add code here to process the content.
       // }
       // v.Close();

       // // Check whether the document is valid or invalid.
       // if (isValid)
       //     Console.WriteLine("Document is valid");
       // else
       //     Console.WriteLine("Document is invalid");

       //}

    public static void MyValidationEventHandler(object sender,  ValidationEventArgs args)
    {
        isValid = false;
        Console.WriteLine("Validation event\n" + args.Message);
    }
	
   
}