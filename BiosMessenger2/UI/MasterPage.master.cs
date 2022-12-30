using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using RefServicio;
using System.Xml;
using System.Xml.Linq;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!(Session["UsuarioMP"] is Usuario))
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                Usuario usuario = (Usuario)Session["UsuarioMP"];

                lblUsuario.Text = usuario.Nombre + " " + usuario.Apellido;
            }
        }
        catch
        {
            Response.Redirect("~/Default.aspx");
        }
    }
}
