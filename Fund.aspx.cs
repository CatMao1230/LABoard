using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Fund : System.Web.UI.Page
{
    // SQL1為Fund_Month, SQL2為FundList, SQL3為Fund_Category, SQL4為User
    Boolean isLogin = false;
    String Name;
    //計算金額總和
    string zSum = " SELECT SUM([Price]) " + "FROM[LABoard].[dbo].[FundList] ";      

    private double Price;
    private DataSet getData()
    {
        String connectString = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection cn = new SqlConnection(connectString);
        String selectString = "SELECT * FROM [LABoard].[dbo].[FundList]";
        SqlCommand cmd = new SqlCommand(selectString, cn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        cn.Open();
        da.Fill(ds);
        cn.Close();
        return ds;
    }
    private void GVgetData()
    {
        // GridView2.DataSource = getData();
        GridView2.DataBind();
    }
    protected void SUM()
    {
        //計算總金額部分
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zSum, conn);
        conn.Open();
        object result = cmd.ExecuteScalar();
        lblTotalmoney.Text = Convert.ToString(result);
        conn.Close();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (int.Parse(Session["Rank"].ToString()) == 0)
        {
            Response.Redirect("Login.aspx");
        }
        if (Session["Account"] != null)
        {
            isLogin = true;
            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
            conn.Open();
            String strSQL = @"SELECT * FROM [User] WHERE Account = @eAccount";
            SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = Session["Account"].ToString();
            SqlDataReader dataUser = cmd.ExecuteReader();

            while (dataUser.Read()) //讀取結果
            {
                Name = dataUser["Name"].ToString();
                lblAccount.Text = Name;
                tbxName.Text = Name;
                imgUser.ImageUrl = "Image/" + Session["Account"].ToString() + ".jpg";

                if ((int)dataUser["Rank"] == 5)
                {
                    aManager.Visible = true;
                }
            }

            conn.Close();
            /*
            tbxYear.Text = DateTime.Now.Year.ToString();
            tbxMonth.Text = DateTime.Now.Month.ToString();
            tbxDay.Text = DateTime.Now.Day.ToString();*/
        }
        else // 非法登入
        {
            isLogin = false;
            Response.Redirect("Login.aspx");
        }

        SUM();  //總額

        //抓當前月
        if(!IsPostBack)
        {
            DropDownList1.SelectedValue = DateTime.Now.Month.ToString();
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

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        //新增資料
        string zInsertByID = "INSERT INTO [LABoard].[dbo].[FundList] "
            + "([Year] ,[Month] ,[Day] ,[UserName] ,[Item] ,[Category] ,[Price] )" +
            "VALUES (@year,@month,@day,@name,@item,@category ,@money)";
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zInsertByID, conn);

        cmd.Parameters.Add("@year", SqlDbType.Int).Value = tbxYear.Text;
        cmd.Parameters.Add("@month", SqlDbType.Int).Value = tbxMonth.Text;
        cmd.Parameters.Add("@day", SqlDbType.Int).Value = tbxDay.Text;
        cmd.Parameters.Add("@name", SqlDbType.NVarChar).Value = tbxName.Text;
        cmd.Parameters.Add("@item", SqlDbType.NVarChar).Value = tbxItem.Text;
        cmd.Parameters.Add("@category", SqlDbType.NVarChar).Value = DDLCategory.Text;
        cmd.Parameters.Add("@money", SqlDbType.Int).Value = tbxMoney.Text;
        conn.Open();
        int rows = cmd.ExecuteNonQuery();
        conn.Close();

        DropDownList1.SelectedValue = tbxMonth.Text;  //跳到更新的月份表
        SUM();//算總額
        GridView2.DataBind();

        tbxYear.Text = "";          //清空TEXTBOX
        tbxMonth.Text = "";
        tbxDay.Text = "";
        tbxItem.Text = "";
        tbxMoney.Text = "";
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //每月總額
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Price += Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Price"));
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[5].Text = "本月收支:";
            e.Row.Cells[6].Text = Price.ToString();
            Price = 0;
            e.Row.Font.Bold = true;
        }
    }

    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView2.EditIndex = e.NewEditIndex;
        GVgetData();
    }
    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView2.EditIndex = -1;
        GVgetData();
    }
    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //編輯更新資料庫
        string zUpdateByID = "UPDATE [LABoard].[dbo].[FundList] " + "SET [Year] =@year ,[Month] =@month ,[Day] =@day ,[Item] =@item ,[Category] =@category ,[Price] =@price " +
        "WHERE ([ID]  = @id)  ";
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection cn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zUpdateByID, cn);
        cmd.Parameters.Add("@id", SqlDbType.Int).Value = GridView2.Rows[e.RowIndex].Cells[0].Text;
        cmd.Parameters.Add("@year", SqlDbType.Int).Value = ((TextBox)GridView2.Rows[e.RowIndex].FindControl("tbxy")).Text;
        cmd.Parameters.Add("@month", SqlDbType.Int).Value = ((TextBox)GridView2.Rows[e.RowIndex].FindControl("tbxm")).Text;
        cmd.Parameters.Add("@day", SqlDbType.Int).Value = ((TextBox)GridView2.Rows[e.RowIndex].FindControl("tbxd")).Text;
        cmd.Parameters.Add("@name", SqlDbType.NVarChar).Value = tbxName.Text;
        cmd.Parameters.Add("@item", SqlDbType.NVarChar).Value = ((TextBox)GridView2.Rows[e.RowIndex].FindControl("tbxi")).Text;
        cmd.Parameters.Add("@category", SqlDbType.NVarChar).Value = ((DropDownList)GridView2.Rows[e.RowIndex].FindControl("ddlc")).SelectedValue;
        cmd.Parameters.Add("@money", SqlDbType.Int).Value = ((TextBox)GridView2.Rows[e.RowIndex].FindControl("tbxp")).Text;

        cn.Open();
        cn.Close();
        GridView2.EditIndex = -1;
        GVgetData();
        SUM();
        GridView2.DataBind();          
    }
    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //刪除資料
        string zDeleteByID = "DELETE FROM [LABoard].[dbo].[FundList]  WHERE [ID] =@id  ";
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection cn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zDeleteByID, cn);
        cmd.Parameters.Add("@id", SqlDbType.Int);
        cmd.Parameters["@id"].Value = GridView2.Rows[e.RowIndex].Cells[0].Text;
        cn.Open();
    //      cmd.ExecuteNonQuery();
        cn.Close();          
        GVgetData();
        SUM();
        GridView2.DataBind();
    }
    

}