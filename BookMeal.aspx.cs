using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bookmeal : System.Web.UI.Page
{
    static string[] arrItem = new string[10];
    static int[] arrPrice = new int[10];
    static int[] arrFoodid = new int[10];
    static int index;
    static string temp;

    Boolean isLogin = false;
    String Name;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (int.Parse(Session["Rank"].ToString()) == 0)
        {
            Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            index = 0;

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
                    imgUser.ImageUrl = "Image/" + Session["Account"].ToString() + ".jpg";

                    if ((int)dataUser["Rank"] == 5)
                    {
                        aManager.Visible = true;
                    }

                    if ((int)dataUser["Rank"] >= 4)
                    {
                        DropDownList1.Enabled = true;
                    }
                }

                conn.Close();

                string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
                conn = new SqlConnection(connStr);
                conn.Open();
                strSQL = @"SELECT * FROM [TodayStore]";
                cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
                SqlDataReader data = cmd.ExecuteReader();
                data.Read();
                DropDownList1.SelectedIndex = int.Parse(data["StoreID"].ToString()) - 1;
                conn.Close();
            }
            else // 非法登入
            {
                isLogin = false;
                Response.Redirect("Login.aspx");
            }
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

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
       if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Label idvalue = (Label)e.Item.FindControl("idLabel");
            temp = idvalue.Text;
        }
    }
    
    protected void cbxCheck_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cbxCheck = (CheckBox)sender;
        string str = "";
        int total = 0;
        if (cbxCheck.Checked == true)
        {
            arrItem[index] = ((Label)cbxCheck.Parent.FindControl("itemLabel")).Text;
            arrPrice[index] = int.Parse(((Label)cbxCheck.Parent.FindControl("priceLabel")).Text);
            arrFoodid[index]= int.Parse(((Label)cbxCheck.Parent.FindControl("idLabel")).Text);
            index++;

        }
        else
        {
            for(int i = 0; i < index; i++)
            {
                if(arrItem[i] == ((Label)cbxCheck.Parent.FindControl("itemLabel")).Text)
                {
                    for(int j = i; j < index - 1; j++)
                    {
                        arrItem[j] = arrItem[j + 1];
                        arrPrice[j] = arrPrice[j + 1];
                        arrFoodid[j] = arrFoodid[j + 1];
                    }
                    index--;
                }
            }
        }
        
        for (int i = 0; i < index; i++)
        {
            total += arrPrice[i];
        }
        str = "<table>";
        for (int i = 0; i < index; i++)
        {
            str += "<tr><th>" + arrItem[i] + "</th><th>" + arrPrice[i] + "</th></tr>";
        }

        str += "</table>";

        lblMeal.Text = str;
        lblTotal.Text = "Total:"+total.ToString();
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.ToString());
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (index != 0)
        {
            for (int i = 0; i < index; i++)
            {
                string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
                SqlConnection conn = new SqlConnection(connStr);
                conn.Open();
                String strSQL = @"INSERT INTO [Booklist] ([Account],[FoodID]) " +
                                "VALUES ( @eAccount, @eFoodId )";
                SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
                cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = Session["Account"].ToString();
                cmd.Parameters.Add("@eFoodId", SqlDbType.Int).Value = arrFoodid[i];
                cmd.ExecuteReader();
                conn.Close();
            }

            Response.Write("<Script language='JavaScript'>alert('訂餐成功');location.href='FoodList.aspx';</Script>");
        }
        else
        {
            Response.Write("<Script language='JavaScript'>alert('尚未勾選任何餐點');location.href='BookMeal.aspx';</Script>");
        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);
        conn.Open();
        String strSQL = @"UPDATE [TodayStore] SET [StoreID] = @eStoreID";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eStoreID", SqlDbType.NVarChar).Value = DropDownList1.SelectedValue;
        cmd.ExecuteReader();
        conn.Close();
    }
}