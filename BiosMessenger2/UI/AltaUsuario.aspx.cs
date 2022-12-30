using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using RefServicio;
using System.Xml;
using System.Xml.Linq;

public partial class AltaUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {       
        if (!IsPostBack)
            Limpiar();
    }

    private void Limpiar()
    {
        txtLogueo.Text = string.Empty;
        txtPass.Text = string.Empty;
        txtNombre.Text = string.Empty;
        txtApellido.Text = string.Empty;
        txtMail.Text = string.Empty;
        txtLogueo.Focus();
    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        Usuario U = null;
        try
        {            
            U = new Usuario()
            {
                UsuarioLogueo = txtLogueo.Text.Trim(),
                Contrasena = txtPass.Text.Trim(),
                Nombre = txtNombre.Text.Trim(),
                Apellido = txtApellido.Text.Trim(),
                Mail = txtMail.Text.Trim()
            };            
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-danger";
            return;
        }
        try
        {
            new ServicioEF().AltaUsuario(U);

            Limpiar();
            lblMensaje.Text = "Usuario registrado exitosamente, vuelva a la página de inicio si desea loguearse.";
            lblMensaje.CssClass = "alert alert-primary";
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            lblMensaje.Text = ex.Detail.InnerText;
            lblMensaje.CssClass = "alert alert-danger";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-danger";
        }
    }
}