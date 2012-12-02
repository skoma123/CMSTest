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
using System.Configuration;
using System.Net;
//using Newtonsoft.Json;
using System.Web.Extensions;
using System.Runtime.Serialization;


public partial class _Default : System.Web.UI.Page 
{

    private StringBuilder _builder = new StringBuilder();
    Process process = new Process();

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

            gitInfo.Arguments = @"shortlog -n -s"; //@"log --all --format=""%an <%ae>""" ; //@"shortlog -n -s"; 
            //%Cred%h%Creset - %C(yellow)%s%Creset %C(green)<%an>%Creset"""; //@"log --format=""%aN"" | sort -u"; // such as "fetch orign" //GIT COMMAND
            gitProcess.StartInfo = gitInfo;
            gitProcess.Start();

            //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
            stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT
            stdout_str = stdout_str.Replace("\t", "");
            //clear the listbox
            lstUsers.Items.Clear();
            words = stdout_str.Split('\n');

            foreach (string strtest in words)
                if (strtest != "")
                {
                    lstUsers.Items.Add(strtest.Remove(1,5).Trim());
                    if (strtest.Contains("*"))
                        lstUsers.SelectedValue = strtest;
                }

            //gitInfo.Arguments = "branch -a"; // such as "fetch orign" //GIT COMMAND
            //gitProcess.StartInfo = gitInfo;
            //gitProcess.Start();

            ////stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
            //stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

            ////clear the listbox
            //lstBranches.Items.Clear();
            //words = stdout_str.Split('\n');

            //foreach (string strtest in words)
            //    if (strtest != "") {
            //        lstBranches.Items.Add(strtest.Trim());
            //        if (strtest.Contains("*"))
            //            lstBranches.SelectedValue = strtest;
            //    }

            gitProcess.WaitForExit();
            gitProcess.Close();
      
        }
        else
        {
            if (treeFiles.SelectedValue != null)
            {
                Xml1.DocumentSource = treeFiles.SelectedValue;
            }
        }
        //XmlDocument doc1 = new XmlDocument();
        //doc1.Load(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\UPS747MEL20070815101151.xml");

        //FreeTextBox1.Text = doc1.InnerXml;
        //FreeTextBox1.FormatHtmlTagsToXhtml = true;
     }

    protected void BindTreeView()
    {
        DirectoryInfo dir1 = new DirectoryInfo(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\");
        treeFiles.Nodes.Add(GetNode(dir1));

    }

    protected TreeNode GetNode(DirectoryInfo directoryinfo)
    {
        TreeNode treenode = new TreeNode(directoryinfo.Name, directoryinfo.FullName);
        treenode.SelectAction = TreeNodeSelectAction.None;
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
            treenode.ShowCheckBox = true;
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


    protected void NoLinkWhenExpanded(object sender, TreeNodeEventArgs e)
    {
       e.Node.SelectAction = TreeNodeSelectAction.None;

    }

    protected void treeFiles_SelectedNodeChanged(object sender, EventArgs e)
    {
        try
        {
           
           Xml1.DocumentSource = treeFiles.SelectedValue;
        //   Xml1.TransformSource = "~/CMS/MEL/747/melcdl2html_mod.xsl";
           Xml1.TransformSource = treeFiles.SelectedValue.Replace(treeFiles.SelectedNode.Text, "") + "melcdl2html_mod.xsl"; // "~/CMS/MEL/747/Working/melcdl2html_mod.xsl";
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
              lblMsg.Text = "XML Document not valid, following error:" +  ex.Message + " Correct and validate the fragment";       
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


    protected void btnStage_Click(object sender, EventArgs e)
    {
        //push files from working folder to staging
        //Now Create all of the directories
        foreach (string dirPath in Directory.GetDirectories(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\", "*",
            SearchOption.AllDirectories))
            Directory.CreateDirectory(dirPath.Replace(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\", @"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Staging\"));

        //Copy all the files
        foreach (string newPath in Directory.GetFiles(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\", "*.*",
            SearchOption.AllDirectories))
            File.Copy(newPath, newPath.Replace(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\", @"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Staging\"));


        //then stage, commit, and push new folder
        InitialProcessing();
        gitInfo.Arguments = @"stage CMS/MEL/747/*.*";
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

        treeFiles.Nodes.Clear();
        BindTreeView();

        //copy the contents from working to staging
        //Directory.GetFiles(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\*.*");

        //foreach(var file in Directory.GetFiles(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\*.*"))
        //File.Copy(file, Path.Combine(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Staging\", Path.GetFileName(file)));
        //process.StartInfo.FileName = "xcopy";
        //process.StartInfo.Arguments = @"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\*.* C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Staging\ /e /y /I";
        //process.Start();
        //bool lp = process.WaitForExit(10000);
        
    }

    static void DeleteCouchDB(string name)
    {

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://127.0.0.1:5984/" + name.ToLower());    
        request.Method ="DELETE";   
        using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
        {
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            {
                Console.WriteLine(reader.ReadToEnd()); //response should be {"ok":true}
            }  
        }    
    }
    public class XMLFragment
    {
        public string fleet;
        public string manual;
        public string docpath;
        public string xmldata;
        //public string _id;
    }

    public void CreateDocument(string content)
    {

        //create it user PUT instead of POST. PUT is secure but requires the _id to be passed, so it gives you more control.
        //POST automatically creates the id and revision.

        //Where should be store images, can attach to the XML fragment but if common to other XML fragments then we can store in a common place
        //and access image based on the graphics. Can stored the image list as the record or read them while loading the file.
        //CreateDocument("http://127.0.0.1:5984/cms/newdocXYZ", "");

        //new record needs id, fleet (ex:747), manual (ex:MEL), docpath (ex: MEL/747/staging - where the doc was staged to deploy to Couch). 
        //if no id is provided, it will autogenerate, we want to handle it ourselves
        List<XMLFragment> eList = new List<XMLFragment>();
        XMLFragment e = new XMLFragment();
        //e._id = "new123";
        e.fleet = "747";
        e.manual = "MEL";
        e.docpath = "MEL/747/Staging/new456";

        StringWriter rs1 = new StringWriter();
        XmlWriter rs2 = XmlWriter.Create(rs1);

        XmlDocument doc1 = new XmlDocument();
        doc1.Load(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\747\Working\UPS747MEL20070815101151.xml");

        e.xmldata = doc1.InnerXml; // @"<?xml version=""1.0"" encoding=""UTF-""?><Bookmark><Title Named=""lec"" Action=""GoTo"" >HIGHLIGHTS OF CHANGES</Title></Bookmark>";

        eList.Add(e);

        //e = new XMLFragment();
        //e.Fleet = "757";
        //e.Manual = "MEL";

        //eList.Add(e);

        System.Web.Script.Serialization.JavaScriptSerializer oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        string sJSON = oSerializer.Serialize(eList);

       // string ans = JsonConvert.SerializeObject(eList); // JsonConvert.SerializeObject(eList, Formatting.Indented);
        
        DoRequest("http://127.0.0.1:5984/cms/newdocXYZ", "PUT", sJSON.TrimStart('[').TrimEnd(']'), "application/json"); 

     
       } 

    static void CreateNewCouchDB(string name)
    {
             //******create new db   
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://127.0.0.1:5984/" + name.ToLower());  
        request.Method ="PUT";   
        using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())    
        {        
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))       
            {
                Console.WriteLine(reader.ReadToEnd());    //response should be {"ok":true}    
            }
        }
    }

    public void DeleteDocument(string server, string db, string docid) {
        DoRequest("http://127.0.0.1:5984/cms/1a?rev=3-0089c796210167d456f8e15f0c8dd0b1", "DELETE"); 
    } 

       private string DoRequest(string url,string method,string postdata,string contenttype)          
       {           
           HttpWebRequest req=WebRequest.Create(url) as HttpWebRequest;   
           req.Method=method;                       
           // Yuk - set an infinite timeout on this for now, because       
           // executing a temporary view (for example) can take a very   
           // long time...                        
           req.Timeout=System.Threading.Timeout.Infinite;  
           if(contenttype!=null)   
               req.ContentType=contenttype;  
           if(postdata!=null)              
           {   
               byte[] bytes=UTF8Encoding.UTF8.GetBytes(postdata.ToString());      
               req.ContentLength=bytes.Length; 
               using(Stream ps = req.GetRequestStream())  
               {
                   ps.Write(bytes, 0, bytes.Length);  
               }   
           }
           HttpWebResponse resp = (HttpWebResponse)req.GetResponse();
           //HttpWebResponse resp=req.GetResponse() as HttpWebResponse; 
           string result; 
           using(StreamReader reader=new StreamReader(resp.GetResponseStream()))
           { 
               result=reader.ReadToEnd();
           } 
           return result;
       }                 

    static void GetDatabaseInfo(string name)
    {
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://127.0.0.1:5984/" + name.ToLower()); //ex: cms
        request.Method = "GET";

        using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
        {
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            {
                Console.WriteLine(reader.ReadToEnd());
            }
        }
    }

    protected void btnCouch_Click(object sender, EventArgs e)
    {
        System.Net.HttpWebRequest webRequest = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(System.Configuration.ConfigurationManager.AppSettings.Get("CouchServer") + "/1a");
        //webRequest.Credentials = new System.Net.NetworkCredential(System.Configuration.ConfigurationManager.AppSettings.Get("apiUserName"), System.Configuration.ConfigurationManager.AppSettings.Get("apiPassword"));
       
        //webRequest.Method = "HEAD" 'faster to check if ID is valid, no content body is returned
            webRequest.Method = "GET"; //gets content body
            webRequest.Accept = "application/json";
            System.Net.WebResponse responseID   = webRequest.GetResponse();


           // g1 = JSONHelper.Deserialise<GoogleSearchResults>(json);
           // Response.Write(g1.content);

                StreamReader streamReader = new System.IO.StreamReader(responseID.GetResponseStream());
                string text1;
                using (var sr = new StreamReader(responseID.GetResponseStream()))
                {
                    text1 = sr.ReadToEnd();
                }

        //*********all documents  http://127.0.0.1:5984/cms/_all_docs
        //*********all DBs http://127.0.0.1:5984/_all_dbs
        //*********all docs in range http://127.0.0.1:5984/cms/_all_docs?include_docs=true&startkey="1a"&endkey="1c"

                //HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://127.0.0.1:5984/cms/1b");
                //request.Method = "DELETE";
                //using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                //{
                //    using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                //    {
                //        Console.WriteLine(reader.ReadToEnd());    //response should be {"ok":true}    
                //    }
                //}
                //MUST pass the latest revision of doc to delete, get it first
               //**WORKING DoRequest("http://127.0.0.1:5984/cms/1b?rev=6-0650b47891557eb0b393ae206888284c", "DELETE"); 


   
  }

    private string DoRequest(string url, string method) 
    {
        return DoRequest(url, method, null, null); 
    }  

        //User user = new User();
        //user.Name = "Igloo Snc";
        //user.Save();

        //user.FetchById("74c461d3f5c70029de65f85873000ea7");

        //user.Delete();


    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        CreateDocument("");
        //MUST pass the latest revision of doc to delete, get it first
        //**WORKING DoRequest("http://127.0.0.1:5984/cms/1b?rev=6-0650b47891557eb0b393ae206888284c", "DELETE"); 
    }
    protected void btnLookup_Click(object sender, ImageClickEventArgs e)
    {
        lblGitCommand.Text = "";
        lstAll.Items.Clear();
        InitialProcessing();
        gitInfo.Arguments = @"grep """ + txtSearchRepo.Text + ""; //""Operations"""; //@"log --stat --name-only --pretty=""%h | %s %an | %ar | %s | %cn | %cr"" --author=skoma123 --graph --decorate --all --since=""2012-10-01"" --before=""2012-11-30"" --no-merges"; //"log --pretty=oneline"; // "log --stat"; // such as "fetch orign" //GIT COMMAND
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
    protected void btnConflict_Click(object sender, EventArgs e)
    {

    }

    protected void ImageButton1_Click1(object sender, ImageClickEventArgs e)
    {
        lstAll.Items.Clear();
        InitialProcessing();
        gitInfo.Arguments = @"blame CMS/MEL/747/Working/" + @treeFiles.SelectedNode.Text;
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT


        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                lstAll.Items.Add(strtest);

        if (lstAll.Items.Count != 0)
        {
            lblGitCommand.Text = @"Shows what revision and author last modified each line of a file";
        }

        gitProcess.WaitForExit();
        gitProcess.Close();
    }
    protected void btnCommitHistDetail_Click(object sender, ImageClickEventArgs e)
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

        if (lstAll.Items.Count != 0)
        {
            lblGitCommand.Text = @"Detail committed and merged history";
        }
    }
    protected void btnCommitHistSimple_Click(object sender, ImageClickEventArgs e)
    {
        lblGitCommand.Text = "";
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

        if (lstAll.Items.Count != 0)
        {
            lblGitCommand.Text = @"Simple committed and merged history";
        }
    }
    protected void btnCommittedNotMerged_Click(object sender, ImageClickEventArgs e)
    {
        lblGitCommand.Text = "";
        lstAll.Items.Clear();
        InitialProcessing();
        gitInfo.Arguments = @"log --stat --name-only --pretty=""%h | %s %an | %ar | %s | %cn | %cr"" --author=skoma123 --graph --decorate --all --since=""2012-10-01"" --before=""2012-11-30"" --no-merges"; //"log --pretty=oneline"; // "log --stat"; // such as "fetch orign" //GIT COMMAND //"diff --stat HEAD^!"; //
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                lstAll.Items.Add(strtest);

        if (lstAll.Items.Count != 0)
        {
            lblGitCommand.Text = @"Committed changes but not merged with master";
        }
        gitProcess.WaitForExit();
        gitProcess.Close();
    }

    protected void btnUploadManual_Click(object sender, ImageClickEventArgs e)
    {
        InitialProcessing();


        Directory.CreateDirectory(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\757\Working\");
        Directory.CreateDirectory(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\757\Staging\");

        //then stage, commit, and push new folder

        gitInfo.Arguments = @"stage CMS/MEL/757/*.*";
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        gitInfo.Arguments = @"commit -am ""Added new folder Manual"""; //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //push files from working folder to staging
        //Now Create all of the directories
        foreach (string dirPath in Directory.GetDirectories(@"C:\Temp\757 MEL", "*",
            SearchOption.AllDirectories))
            Directory.CreateDirectory(dirPath.Replace(@"C:\Temp\757 MEL", @"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\757\Working\"));

        //Copy all the files
        foreach (string newPath in Directory.GetFiles(@"C:\Temp\757 MEL", "*.*",
            SearchOption.AllDirectories))
            File.Copy(newPath, newPath.Replace(@"C:\Temp\757 MEL", @"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\757\Working\"));


        //then stage, commit, and push new folder
        InitialProcessing();
        gitInfo.Arguments = @"stage CMS/MEL/757/*.*";
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();


        gitInfo.Arguments = @"commit -am ""Added new 757 Manual"""; //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();


        gitInfo.Arguments = @"push"; //GIT COMMAND
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        gitProcess.WaitForExit();
        gitProcess.Close();

        treeFiles.Nodes.Clear();
        BindTreeView();
    }
    protected void btnListAll_Click(object sender, ImageClickEventArgs e)
    {
        lblGitCommand.Text = "";
        lstAll.Items.Clear();
        InitialProcessing();
        gitInfo.Arguments = @"ls-files";
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                lstAll.Items.Add(strtest);

        if (lstAll.Items.Count != 0)
        {
            lblGitCommand.Text = @"List of all files within Repository";
        }

        gitProcess.WaitForExit();
        gitProcess.Close();
    }
    protected void btnListbyAuthor_Click(object sender, ImageClickEventArgs e)
    {
        lblGitCommand.Text = "";
        lstAll.Items.Clear();
        InitialProcessing();
        gitInfo.Arguments = @"log --pretty=""%an | %ar | %s"" --author=" + lstUsers.SelectedValue; //add this if want to see detail --name-only
        gitProcess.StartInfo = gitInfo;
        gitProcess.Start();

        //stderr_str = gitProcess.StandardError.ReadToEnd();  // pick up STDERR
        stdout_str = gitProcess.StandardOutput.ReadToEnd(); // pick up STDOUT

        words = stdout_str.Split('\n');

        foreach (string strtest in words)
            if (strtest != "")
                lstAll.Items.Add(strtest);

        if (lstAll.Items.Count != 0) {
            lblGitCommand.Text = @"History for user: " + lstUsers.SelectedValue;
        }
        gitProcess.WaitForExit();
        gitProcess.Close();
    }
    //protected void lstAll_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    lblGitCommand.Text = "";

    //    Xml1.DocumentSource = lstAll.SelectedValue.Substring(0,lstAll.SelectedValue.IndexOf(".xml")) + "xml";
    //    //   Xml1.TransformSource = "~/CMS/MEL/747/melcdl2html_mod.xsl";
    //    tblXML.Visible = true;
    //}
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        
            lblMsg.CssClass = "";
            MultiView1.ActiveViewIndex = Int32.Parse(e.Item.Value);
            if (e.Item.Value == "1") {
                lstAll.Items.Clear();
            }


    }
    protected void btnCheckoutByUser_Click(object sender, ImageClickEventArgs e)
    {
        
        //Create the folders, including entities and styles

        //      Xml1.DocumentSource = treeFiles.SelectedValue;
        ////   Xml1.TransformSource = "~/CMS/MEL/747/melcdl2html_mod.xsl";
        //   Xml1.TransformSource = treeFiles.SelectedValue.Replace(treeFiles.SelectedNode.Text, "") + "melcdl2html_mod.xsl"; // "~/CMS/MEL/747/Working/melcdl2html_mod.xsl";
        //  treeFiles.SelectedNodeStyle.ForeColor = Color.Blue;
     int firstNode = 0;

     if (treeFiles.CheckedNodes.Count == 0)
     {
         lblMsg.Text = "Please select files to checkout";
         lblMsg.ForeColor = Color.Red;
     }
     else
     {
         InitialProcessing();

         //push files from working folder to staging
         foreach (TreeNode node in treeFiles.CheckedNodes)
         {
             if (firstNode == 0)
             {
                 Directory.CreateDirectory(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\Branches\" + lstUsers.SelectedValue + node.Parent.Value.Replace("\\Working", "").Substring(node.Parent.Value.Replace("\\Working", "").LastIndexOf("\\")));
                 gitInfo.Arguments = @"add .";
                 gitProcess.StartInfo = gitInfo;
                 gitProcess.Start();


                 gitInfo.Arguments = @"commit -am ""Created folder for user's branch"""; //GIT COMMAND
                 gitProcess.StartInfo = gitInfo;
                 gitProcess.Start();


             }
             firstNode += 1;
         }

         ////Now Create all of the directories
         //foreach (string dirPath in Directory.GetDirectories(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\" + treeFiles.SelectedValue.Replace(treeFiles.SelectedNode.Text, ""), "*",
         //    SearchOption.AllDirectories))
         //    Directory.CreateDirectory(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\" + treeFiles.SelectedValue.Replace(treeFiles.SelectedNode.Text, ""));



         ////    NextPrevFormat
         ////Directory.CreateDirectory(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\757\Working\");
         ////Directory.CreateDirectory(@"C:\Users\air0sxk\Documents\Visual Studio 2010\Websites\CTestGitAPP\CMS\MEL\757\Staging\");

         ////then stage, commit, and push new folder
         //InitialProcessing();
         //gitInfo.Arguments = @"stage CMS/MEL/757/*.*";
         //gitProcess.StartInfo = gitInfo;
         //gitProcess.Start();


         //gitInfo.Arguments = @"commit -am ""Checkout files to user's branch"""; //GIT COMMAND
         //gitProcess.StartInfo = gitInfo;
         //gitProcess.Start();


         ////gitInfo.Arguments = @"push"; //GITHIB remote COMMAND
         ////gitProcess.StartInfo = gitInfo;
         ////gitProcess.Start();

         //gitProcess.WaitForExit();
         //gitProcess.Close();

         treeFiles.Nodes.Clear();
         BindTreeView();
     }
    }
}


