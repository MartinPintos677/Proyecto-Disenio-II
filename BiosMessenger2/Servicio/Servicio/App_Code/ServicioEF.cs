using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using ModeloEF;
using System.Web.Services.Protocols;
using System.Xml;


[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

public class ServicioEF : WebService
{
    private void GeneroSoapException(Exception ex)
    {
        XmlDocument _undoc = new XmlDocument();
        XmlNode _NodoError = _undoc.CreateNode(XmlNodeType.Element, SoapException.DetailElementName.Name, SoapException.DetailElementName.Namespace);

        XmlNode _NodoDetalle = _undoc.CreateNode(XmlNodeType.Element, "Error", "");
        _NodoDetalle.InnerText = ex.Message;

        _NodoError.AppendChild(_NodoDetalle);

        SoapException _MiEx = new SoapException(ex.Message, SoapException.ClientFaultCode, Context.Request.Url.AbsoluteUri, _NodoError);

        throw _MiEx;
    }

    [WebMethod]
    public Usuario LogueoUsuario(string usu, string pass)
    {
        Usuario _unU = null;
        try
        {
            _unU = LogicaModeloEF.LogueoUsuario(usu, pass);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _unU;
    }
    [WebMethod]
    public Usuario BuscarUsuario(string usu)
    {
        Usuario _unU = null;
        try
        {
            _unU = LogicaModeloEF.BuscarUsuario(usu);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _unU;
    }
    [WebMethod]
    public void EliminarUsuario(Usuario unU)
    {
        try
        {
            LogicaModeloEF.EliminarUsuario(unU);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }
    [WebMethod]
    public void ModificarUsuario(Usuario unU)
    {
        try
        {
            LogicaModeloEF.ModificarUsuario(unU);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }
    [WebMethod]
    public void AltaUsuario(Usuario unU)
    {
        try
        {
            LogicaModeloEF.AltaUsuario(unU);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }
    [WebMethod]
    public void EliminarTipodeMensaje(TipodeMensaje unT)
    {
        try
        {
            LogicaModeloEF.EliminarTipoMensaje(unT);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }
    [WebMethod]
    public void ModificarTipodeMensaje(TipodeMensaje unT)
    {
        try
        {
            LogicaModeloEF.ModificarTipoMensaje(unT);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }
    [WebMethod]
    public TipodeMensaje BuscarTipodeMensaje(string tipo)
    {
        TipodeMensaje _unT = null;
        try
        {
            _unT = LogicaModeloEF.BuscarTipoMensaje(tipo);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _unT;
    }
    [WebMethod]
    public void AltaTipodeMensaje(TipodeMensaje tipo)
    {
        try
        {
            LogicaModeloEF.AltaTipoMensaje(tipo);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }
    [WebMethod]
    public List<TipodeMensaje> ListarTiposdeMensaje()
    {
        List<TipodeMensaje> _lista = null;
        try
        {
            _lista = LogicaModeloEF.ListarTiposMensaje();
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _lista;
    }
    [WebMethod]
    public void AltaMensaje(Mensaje unM)
    {
        try
        {
            LogicaModeloEF.AltaMensaje(unM);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
    }
    [WebMethod]
    public List<Mensaje> ListarMensajesRecibidos(Usuario usuario)
    {
        List<Mensaje> _lista = null;
        try
        {
            _lista = LogicaModeloEF.ListarMensajesRecibidos(usuario);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _lista;
    }
    [WebMethod]
    public List<Mensaje> ListaMensajesEnviados(Usuario usuario)
    {
        List<Mensaje> _lista = null;
        try
        {
            _lista = LogicaModeloEF.ListaMensajesEnviados(usuario);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _lista;
    }
    [WebMethod]
    public List<Mensaje> ListarRecibidosTipoFecha(Usuario usuario, TipodeMensaje tipo = null, DateTime fecha = new DateTime())
    {
        List<Mensaje> _lista = null;
        try
        {
            _lista = LogicaModeloEF.ListarRecibidosTipoFecha(usuario, tipo, fecha);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _lista;
    }
    [WebMethod]
    public List<Mensaje> ListaEnviadosTipoFecha(Usuario usuario, TipodeMensaje tipo = null, DateTime fecha = new DateTime())
    {
        List<Mensaje> _lista = null;
        try
        {
            _lista = LogicaModeloEF.ListaEnviadosTipoFecha(usuario, tipo, fecha);
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _lista;
    }
    [WebMethod]
    public int CantidadUsuarios()
    {
        int cantidad = 0;
        try
        {
            cantidad = LogicaModeloEF.CantidadUsuarios();
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return cantidad;
    }
    [WebMethod]
    public int CantidadMensajesEnviados()
    {
        int cantidad = 0;
        try
        {
            cantidad = LogicaModeloEF.CantidadMensajesEnviados();
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return cantidad;
    }
    
    [WebMethod]
    public XmlDocument CantidadTipos()
    {
        XmlDocument xml = null;
        try
        {
            xml = LogicaModeloEF.CantidadTipos();
        }
       catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return xml;
    }

    [WebMethod]
    public List<object> Destinatarios(Mensaje M)
    {
        List<object> _lista = null;
        try
        {
            _lista = LogicaModeloEF.Destinatarios(M).ToList();
        }
        catch (Exception ex)
        {
            this.GeneroSoapException(ex);
        }
        return _lista;
    }    
}
