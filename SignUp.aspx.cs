using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;

public partial class SignUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        tbxBirthday.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }

    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        int count = 0;

        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"SELECT COUNT(*) FROM [User] WHERE Account = @eAccount";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = tbxAccount.Text;
        SqlDataReader data = cmd.ExecuteReader();
        //Response.Write("<Script language='JavaScript'>alert('" + data  + "');</Script>");

        while (data.Read())
        {
            count = (int)data[0];
        }
        data.Close();
        if (count == 0) // 未重複
        {
            strSQL = @"INSERT INTO [User] ([Account], [Password], [Name], [Birthday], [Phone], [Email], [Rank]) " +
                                    "VALUES ( @eAccount, @ePassword, @eName, @eBirthday, @ePhone, @eEmail, 0 )";
            cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = tbxAccount.Text;
            cmd.Parameters.Add("@ePassword", SqlDbType.NVarChar).Value = getMd5Method(tbxPassword.Text);
            cmd.Parameters.Add("@eName", SqlDbType.NChar).Value = tbxName.Text;
            cmd.Parameters.Add("@eBirthday", SqlDbType.DateTime).Value = Convert.ToDateTime(tbxBirthday.Text);
            cmd.Parameters.Add("@ePhone", SqlDbType.NChar).Value = tbxPhone.Text;
            cmd.Parameters.Add("@eEmail", SqlDbType.NVarChar).Value = tbxEmail.Text;
            data = cmd.ExecuteReader();
            conn.Close();
            Response.Write("<Script language='JavaScript'>alert('等候管理員批准。'); document.location.href='Login.aspx';</Script>");
        }
        else // 重複
        {
            conn.Close();
            Response.Write("<Script language='JavaScript'>alert('帳號重複，註冊失敗。');</Script>");
        }
        /*
                if (data > 0)
                {
                    conn.Close();
                    Response.Write("<Script language='JavaScript'>alert('帳號重複，註冊失敗。');</Script>");

                }
                else
                {
                    strSQL = @"INSERT INTO [User] ([Account], [Password], [Name], [Birthday], [Phone], [Email], [Rank]) " +
                                    "VALUES ( @eAccount, @ePassword, @eName, @eBirthday, @ePhone, @eEmail, 0 )";
                    cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
                    cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = tbxAccount.Text;
                    cmd.Parameters.Add("@ePassword", SqlDbType.NVarChar).Value = getMd5Method(tbxPassword.Text);
                    cmd.Parameters.Add("@eName", SqlDbType.NChar).Value = tbxName.Text;
                    cmd.Parameters.Add("@eBirthday", SqlDbType.DateTime).Value = Convert.ToDateTime(tbxBirthday.Text);
                    cmd.Parameters.Add("@ePhone", SqlDbType.NChar).Value = tbxPhone.Text;
                    cmd.Parameters.Add("@eEmail", SqlDbType.NVarChar).Value = tbxEmail.Text;
                    SqlDataReader dataUser = cmd.ExecuteReader();
                    conn.Close();
                    Response.Write("<Script language='JavaScript'>alert('等候管理員批准。'); document.location.href='Login.aspx';</Script>");
                }*/
    }
    private string getMd5Method(string input)
    {
        MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();

        byte[] myData = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));
        StringBuilder sBuilder = new StringBuilder();

        for (int i = 0; i < myData.Length; i++)
        {
            sBuilder.Append(myData[i].ToString("x"));
        }

        return string.Format("{0}", sBuilder.ToString());
    }
}