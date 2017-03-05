using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class GoodsList : System.Web.UI.Page
{
    string zInsertByID = "INSERT INTO [LABoard].[dbo].[GoodsList] "
        + "([Goods] ,[Num] ,[Remarks] )" +
        "VALUES (@goods ,@num ,@remark )"+
        "SELECT scope_identity() ";

    string zInsertItem = "INSERT INTO [LABoard].[dbo].[Goods_Item] "
        + "([GoodsID] ,[Name] )" +
        "VALUES (@goodsid , @name ) ";

    string zUpdateByID = "UPDATE [LABoard].[dbo].[GoodsList] "
        + "SET [Goods] =@goods ," + "[Num] =@nums ," + "[Remarks] =@remarks "+
        "WHERE [Goods] =@goods  ";  //還沒打抓取自動編號的值  所以先抓名字

    protected void Page_Load(object sender, EventArgs e)
    {
        if (int.Parse(Session["Rank"].ToString()) == 0)
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zInsertByID, conn);

      //  cmd.Parameters.Add("@id", SqlDbType.Int).Value = tbxNos.Text;
        cmd.Parameters.Add("@goods", SqlDbType.NVarChar).Value = tbxGoods.Text;
        cmd.Parameters.Add("@num", SqlDbType.NVarChar).Value = tbxNums.Text;
        cmd.Parameters.Add("@remark", SqlDbType.NVarChar).Value = tbxRemarks.Text;

        conn.Open();
        int rows = cmd.ExecuteNonQuery();
        conn.Close();
        ListView1.DataBind();

        int number = int.Parse(tbxNums.Text);
        for(int i = 0; i < number; i++)
        {
            string connStr2 = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
            SqlConnection conn2 = new SqlConnection(connStr2);
            SqlCommand cmd2 = new SqlCommand(zInsertItem, conn2);

            cmd2.Parameters.Add("@name", SqlDbType.NVarChar).Value = tbxGoods.Text;
       //     cmd2.Parameters.Add("@goodsid", SqlDbType.VarChar).Value = tbxNos.Text;
            conn2.Open();
            int rows2 = cmd2.ExecuteNonQuery();
            conn2.Close();
        }

    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btnEdit = (Button)sender;
        Label lblGood = (Label)btnEdit.Parent.FindControl("lblGood");
        Label lblNum = (Label)btnEdit.Parent.FindControl("lblNum");
        Label lblRemark = (Label)btnEdit.Parent.FindControl("lblRemark");
        TextBox tbxGood = (TextBox)btnEdit.Parent.FindControl("tbxGood");
        TextBox tbxNum = (TextBox)btnEdit.Parent.FindControl("tbxNum");
        TextBox tbxRemark = (TextBox)btnEdit.Parent.FindControl("tbxRemark");
        Button btnAdd = (Button)btnEdit.Parent.FindControl("btnAdd");
        lblGood.Visible = false;
        lblNum.Visible = false;
        lblRemark.Visible = false;
        tbxGood.Visible = true;
        tbxNum.Visible = true;
        tbxRemark.Visible = true;
        tbxGood.Text = lblGood.Text;
        tbxNum.Text = lblNum.Text;
        tbxRemark.Text = lblRemark.Text;
        btnAdd.Visible = true;
        btnEdit.Visible = false;
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Button btnAdd= (Button)sender;
        Label lblGood = (Label)btnAdd.Parent.FindControl("lblGood");
        Label lblNum = (Label)btnAdd.Parent.FindControl("lblNum");
        Label lblRemark = (Label)btnAdd.Parent.FindControl("lblRemark");
        TextBox tbxGood = (TextBox)btnAdd.Parent.FindControl("tbxGood");
        TextBox tbxNum = (TextBox)btnAdd.Parent.FindControl("tbxNum");
        TextBox tbxRemark = (TextBox)btnAdd.Parent.FindControl("tbxRemark");
        Button btnEdit = (Button)btnAdd.Parent.FindControl("btnAdd");

        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zUpdateByID, conn);
        //  cmd.Parameters.Add("@id", SqlDbType.Int).Value = tbxNos.Text;
        cmd.Parameters.Add("@goods", SqlDbType.NVarChar).Value = tbxGood.Text;
        cmd.Parameters.Add("@nums", SqlDbType.NVarChar).Value = tbxNum.Text;
        cmd.Parameters.Add("@remarks", SqlDbType.NVarChar).Value = tbxRemark.Text;

        conn.Open();
        int rows = cmd.ExecuteNonQuery();
        conn.Close();
        ListView1.DataBind();

        lblGood.Visible = true;
        lblNum.Visible = true;
        lblRemark.Visible = true;
        tbxGood.Visible = false;
        tbxNum.Visible = false;
        tbxRemark.Visible = false;
        tbxGood.Text = lblGood.Text;
        tbxNum.Text = lblNum.Text;
        tbxRemark.Text = lblRemark.Text;
        btnAdd.Visible = false;
        btnEdit.Visible = true;
    }


    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        
    }
}