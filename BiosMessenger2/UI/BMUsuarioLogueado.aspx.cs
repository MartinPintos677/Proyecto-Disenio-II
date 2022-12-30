using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using RefServicio;
using System.Xml;
using System.Xml.Linq;

public partial class BMUsuarioLogueado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Limpiar();
    }

    private void Limpiar()
    {
        Usuario usuario = (Usuario)Session["UsuarioMP"];

        txtNombre.Text = usuario.Nombre;
        txtApellido.Text = usuario.Apellido;
        txtPass.Text = usuario.Contrasena;
        txtMail.Text = usuario.Mail;
        txtPass.Focus();
    }
    protected void btnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            Usuario usuario = (Usuario)Session["UsuarioMP"];

            usuario.Nombre = txtNombre.Text.Trim();
            usuario.Apellido = txtApellido.Text.Trim();
            usuario.Contrasena = txtPass.Text.Trim();
            usuario.Mail = txtMail.Text.Trim();

            new ServicioEF().ModificarUsuario(usuario);

            Limpiar();
            lblMensaje.Text = "Modificación correcta.";
            lblMensaje.CssClass = "alert alert-success";
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            lblMensaje.Text = ex.Detail.InnerText;
            lblMensaje.CssClass = "alert alert-warning";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            Usuario usuario = (Usuario)Session["UsuarioMP"];

            new ServicioEF().EliminarUsuario(usuario);

            Response.Redirect("~/Default.aspx");
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            lblMensaje.Text = ex.Detail.InnerText;
            lblMensaje.CssClass = "alert alert-warning";
            return;
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
            return;
        }
    }
}