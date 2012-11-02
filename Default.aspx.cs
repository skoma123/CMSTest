using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using GitSharp;
using System.Diagnostics;
using System.IO;
using System.Text;
public partial class _Default : System.Web.UI.Page 
{
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

        Response.Write("<script>alert('Again')</script>");


    }
}