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

public partial class _Default : System.Web.UI.Page 
{



    ProcessStartInfo gitInfo = new ProcessStartInfo();


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

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Opening an existing git repository
        Repository repo = new Repository(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP");

        //Response.Write("<script>alert('Again')</script>");
        gitInfo.CreateNoWindow = true;
        gitInfo.RedirectStandardError = true;
        gitInfo.RedirectStandardOutput = true;
        gitInfo.UseShellExecute = false;
        gitInfo.FileName = @"C:\Program Files\Git" + @"\bin\git.exe";

   
        //git processes to run
        Process gitProcess = new Process();
        gitInfo.WorkingDirectory = @"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP"; //"D:\data\FileShareGITsample\"; //YOUR_GIT_REPOSITORY_PATH;

        gitInfo.Arguments = "ls-files"; // such as "fetch orign" //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //list files git ls-files

        string stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        string stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT
        ListBox1.Items.Clear();
        string[] words = stdout_str.Split(new string[] { "\n", "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
        foreach (string strtest in words)
            if (strtest != "")
                ListBox1.Items.Add(strtest);

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
        
        gitInfo.Arguments = "branch -a"; // such as "fetch orign" //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        //clear the listbox
        lstBranches.Items.Clear();
        words = stdout_str.Split(' ');

        foreach (string strtest in words)
            if (strtest != "")
            lstBranches.Items.Add(strtest);

        //commit history (authorname, author date, subject, committer name, committed date)
        gitInfo.Arguments = @"log --pretty=format:""%an | %ar | %s | %cn | %cr"""; //"log --pretty=oneline"; // "log --stat"; // such as "fetch orign" //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //git log -p -2 difference introduced in each commit

        stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        lstCommitHistorySimple.Items.Clear();
        words = stdout_str.Split('\n');

       foreach (string strtest in words)
            if (strtest != "")
                //lstCommitHistorySimple.Items.Add(strtest);
                lstCommitHistorySimple.Items.Add(strtest);
       //commit history
       gitInfo.Arguments = "log --stat"; // such as "fetch orign" //GIT COMMAND
       gitProcess.StartInfo = gitInfo;
       gitProcess.Start();

       //git log -p -2 difference introduced in each commit

       stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
       stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

       lstCommitHistory.Items.Clear();
       words = stdout_str.Split('\n');

       foreach (string strtest in words)
           if (strtest != "")
               lstCommitHistory.Items.Add(strtest);

       //list of commits made in last 2 weeks "log --since=2.weeks"
       //last commit This seems a bit clearer. It’s also common to add a last command, like this: $ git config --global alias.last 'log -1 HEAD'
       //This way, you can see the last commit easily: $ git last

        gitInfo.Arguments = @"log --pretty=""%h - %s"" --author=skoma123 --graph --decorate --all --since=""2012-10-01"" --before=""2012-11-01"" --no-merges"; //"log --pretty=oneline"; // "log --stat"; // such as "fetch orign" //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        lstCommittedNotMerged.Items.Clear();
        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                lstCommittedNotMerged.Items.Add(strtest);

        gitProcess.WaitForExit();
        gitProcess.Close();

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
        //***************STAGE, COMMIT with comment **git stage CMS/MEL/*.* // **git commit -am "my commit message
        //***PUSH to remote location ****git push

        //
        }
}