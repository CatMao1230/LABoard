using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    string InsertContent =
        "insert into [ToDoList] " +
        "([Content],[id],[Finished]) " +
        "values(@econt,@eid,@efinished)";


    string Updatefinish =
        "update [ToDolist] " +
        "set [finished] =@f " +
        "where [id]=@id ";

    string Deletedata =
        "delete from [Todolist] " +
        "where [id]=@did ";
  


    Boolean isLogin = false;
    String Name;
    protected void Page_Load(object sender, EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
        fBtn.ForeColor = System.Drawing.Color.White;
        fBtn.BackColor = System.Drawing.Color.Red;
        fBtn.BorderWidth = 2;
        nfBtn.ForeColor = System.Drawing.Color.Gray;
        nfBtn.BackColor = System.Drawing.Color.White;
        if (int.Parse(Session["Rank"].ToString()) == 0)
        {
            Response.Redirect("Login.aspx");
        }

        if (Session["Account"] != null)
        {
            SqlConnection conn = new SqlConnection(@"Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
            conn.Open();
            String strSQL = @"SELECT * FROM [User] WHERE Account = @eAccount";
            SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = Session["Account"].ToString();
            SqlDataReader dataUser = cmd.ExecuteReader();

            while (dataUser.Read()) //讀取結果
            {
                Name = dataUser["Name"].ToString();
                lblAccount.Text = Name;
                imgUser.ImageUrl = "Image/" + Session["Account"].ToString() + ".jpg";

                if ((int)dataUser["Rank"] == 5)
                {
                    aManager.Visible = true;
                }
            }

            conn.Close();
        }
        else // 非法登入
        {
            isLogin = false;
            Response.Redirect("Login.aspx");
        }
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        if (isLogin) //登出
        {
            lblAccount.Text = "尚未登入";
            Session.Remove("Account");
            Response.Redirect("Login.aspx");
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {
        
    }

    protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
    {
       

       


    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
        fBtn.ForeColor = System.Drawing.Color.White;
        fBtn.BackColor = System.Drawing.Color.Red;
        nfBtn.ForeColor = System.Drawing.Color.Gray;
        nfBtn.BackColor = System.Drawing.Color.White;

        for (int i = 0; i < Contentcbl.Items.Count; i++)
        {

            if (Contentcbl.Items[i].Value == bool.TrueString)
            {
                Contentcbl.Items[i].Attributes.Add("style", "display:none");
            }


        }
        Contentcbl.DataBind();
       
       
    }
    protected void FinishedBtn_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < Contentcbl.Items.Count; i++)
        {

            if (Contentcbl.Items[i].Selected)
            {
                string connStr = @"Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";

        SqlConnection conn = new SqlConnection(connStr);

                SqlCommand cmd = new SqlCommand(Updatefinish, conn);

                cmd.Parameters.Add("@id", SqlDbType.Int).Value = Contentcbl.Items[i].Value;
                cmd.Parameters.Add("@f", SqlDbType.Bit).Value = true;

                Contentcbl.Items[i].Attributes.Add("style", "display:none");

                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                conn.Close();

            }


        }

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        DataList1.DataBind();

        MultiView1.ActiveViewIndex = 1;
        nfBtn.ForeColor = System.Drawing.Color.White;
        nfBtn.BackColor = System.Drawing.Color.Red;
        fBtn.ForeColor = System.Drawing.Color.Gray;
        fBtn.BackColor = System.Drawing.Color.White;
    }
    protected void EditBtn_Click(object sender, EventArgs e)
    {
        string connStr = @"Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";

        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand(Deletedata, conn);
        for (int i = 0; i < Contentcbl.Items.Count; i++)
        {
            if (Contentcbl.Items[i].Selected)
            {
                Inputtxb.Text = Contentcbl.SelectedItem.Text;

                cmd.Parameters.Add("@did", SqlDbType.Int).Value = Contentcbl.Items[i].Value;
              
            }
        }
    

        conn.Open();
        int rows = cmd.ExecuteNonQuery();

        conn.Close();
        Contentcbl.DataBind();
    }

    protected void AddBtn_Click(object sender, EventArgs e)
    {

    }
    protected void AddBtn_Click1(object sender, EventArgs e)
    {
        int a = Contentcbl.Items.Count + DataList1.Items.Count;
        string connStr = @"Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";

        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand(InsertContent, conn);

        cmd.Parameters.Add("@econt", SqlDbType.VarChar).Value = Inputtxb.Text;
        cmd.Parameters.Add("@eid", SqlDbType.Int).Value = a;
        cmd.Parameters.Add("@efinished", SqlDbType.Bit).Value = false;

        conn.Open();
        int rows = cmd.ExecuteNonQuery();

        conn.Close();

        Contentcbl.DataBind();
        /*
              for (int i = 0; i < Contentcbl.Items.Count; i++)
              {

                  if (Contentcbl.Items[i].Value == bool.TrueString)
                  {
                      Contentcbl.Items[i].Attributes.Add("style", "display:none");
                  }
          }
          */
        Inputtxb.Text = "";
        
    }
}
