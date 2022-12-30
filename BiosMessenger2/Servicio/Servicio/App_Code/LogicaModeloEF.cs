using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ModeloEF;
using System.Data.SqlClient;
using System.Data;
using System.Xml;
using System.Xml.Linq;

public class LogicaModeloEF
{
    private static BiosMessenger2Entities _VEcontext = null;

    public static BiosMessenger2Entities VEcontext
    {
        get
        {
            if (_VEcontext == null)
            {
                _VEcontext = new BiosMessenger2Entities();
                _VEcontext.Configuration.ProxyCreationEnabled = false;
            }
            return _VEcontext;
        }
    }

    public static Usuario LogueoUsuario(string usu, string pass)
    {
        try
        {
            Usuario _unUsu = VEcontext.Usuario.Where(u => u.UsuarioLogueo == usu.Trim() && u.Contrasena == pass.Trim()).FirstOrDefault();

            if (_unUsu != null)
            {
                return _unUsu;
            }
            else
            {
                throw new Exception("Usuario y/o contraseña incorrectos.");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public static Usuario BuscarUsuario(string logueo)
    {
        return VEcontext.Usuario.Where(a => a.UsuarioLogueo == logueo).FirstOrDefault();
    }

    public static void EliminarUsuario(Usuario unU)
    {
        try
        {
            SqlParameter _logueo = new SqlParameter("@logueo", unU.UsuarioLogueo);
            SqlParameter _retorno = new SqlParameter("@ret", SqlDbType.Int);

            _retorno.Direction = ParameterDirection.Output;

            VEcontext.Database.ExecuteSqlCommand("exec BajaUsuario @logueo, @ret output", _logueo, _retorno);

            if ((int)_retorno.Value == -1)
            {
                throw new Exception("No existe Usuario con el código ingresado.");
            }
            else if ((int)_retorno.Value == -2)
            {
                throw new Exception("No se puede eliminar Usuario con mensajes enviados o recibidos asociados.");
            }
            else
            {                
                VEcontext.SaveChanges();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static void ModificarUsuario(Usuario unU)
    {
        try
        {
            Usuario U = VEcontext.Usuario.Where(a => a.UsuarioLogueo == unU.UsuarioLogueo).FirstOrDefault();

            U.Contrasena = unU.Contrasena;
            U.Nombre = unU.Nombre;
            U.Apellido = unU.Apellido;
            U.Mail = unU.Mail;

            Validar.ValidarUsuario(U);
            VEcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static void AltaUsuario(Usuario unU)
    {
        try
        {
            Validar.ValidarUsuario(unU);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        try
        {
            VEcontext.Usuario.Add(unU);
            VEcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            VEcontext.Entry(unU).State = System.Data.Entity.EntityState.Detached;
            throw ex;
        }
    }
    public static void EliminarTipoMensaje(TipodeMensaje tipo)
    {
        try
        {
            TipodeMensaje T = VEcontext.TipodeMensaje.Where(a => a.Codigo == tipo.Codigo).FirstOrDefault();

            bool encontre = (from unM in VEcontext.Mensaje
                             where unM.TipodeMensaje.Codigo == T.Codigo
                             select unM).Any();

            if (encontre)
                throw new Exception("No se puede eliminar tipo de mensaje que tenga mensajes asociados.");

            VEcontext.TipodeMensaje.Remove(T);
            VEcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static void ModificarTipoMensaje(TipodeMensaje tipo)
    {
        try
        {
            TipodeMensaje T = VEcontext.TipodeMensaje.Where(a => a.Codigo == tipo.Codigo).FirstOrDefault();

            T.Nombre = tipo.Nombre;

            Validar.ValidarTiposMensaje(T);
            VEcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static TipodeMensaje BuscarTipoMensaje(string codigo)
    {
        return VEcontext.TipodeMensaje.Where(a => a.Codigo == codigo).FirstOrDefault();
    }
    public static void AltaTipoMensaje(TipodeMensaje tipo)
    {
        try
        {
            Validar.ValidarTiposMensaje(tipo);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        try
        {
            VEcontext.TipodeMensaje.Add(tipo);
            VEcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            VEcontext.Entry(tipo).State = System.Data.Entity.EntityState.Detached;
            throw ex;
        }
    }
    public static List<TipodeMensaje> ListarTiposMensaje()
    {
        return VEcontext.TipodeMensaje.ToList();
    }

    public static void AltaMensaje(Mensaje unM)
    {
        try
        {
            HashSet<Usuario> receptores = new HashSet<Usuario>();

            for (int i = 0; i < unM.Reciben.Count; i++)
            {
                string usu = unM.Reciben.ElementAt(i).UsuarioLogueo;

                Usuario usuario = VEcontext.Usuario.Where(u => u.UsuarioLogueo == usu).FirstOrDefault();

                receptores.Add(usuario);
            }

            unM.Reciben = receptores;

            string codTipo = unM.TipodeMensaje.Codigo;
            TipodeMensaje unT = VEcontext.TipodeMensaje.Where(t => t.Codigo == codTipo).FirstOrDefault();
            unM.TipodeMensaje = unT;

            string codUsu = unM.Usuario.UsuarioLogueo;
            Usuario unU = VEcontext.Usuario.Where(u => u.UsuarioLogueo == codUsu).FirstOrDefault();
            unM.Usuario = unU;

            unM.FechaHora = DateTime.Now;

            Validar.ValidarMensaje(unM);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        try
        {
            VEcontext.Mensaje.Add(unM);
            VEcontext.SaveChanges();
        }
        catch (Exception ex)
        {
            VEcontext.Entry(unM).State = System.Data.Entity.EntityState.Detached;
            throw ex;
        }
    }

    public static List<Mensaje> ListarMensajesRecibidos(Usuario usuario)
    {
        VEcontext.Usuario.ToList();
        VEcontext.TipodeMensaje.ToList();

        List<Mensaje> lista = (from unU in VEcontext.Mensaje
                               from unR in unU.Reciben
                               where unR.UsuarioLogueo == usuario.UsuarioLogueo
                               orderby unU.FechaHora descending
                               select unU).ToList<Mensaje>();

        return lista;
    }

    public static List<Mensaje> ListaMensajesEnviados(Usuario usuario)
    {
        VEcontext.Usuario.ToList();
        VEcontext.TipodeMensaje.ToList();

        List<Mensaje> lista = (from unU in VEcontext.Mensaje
                               where unU.UsuarioLogueo == usuario.UsuarioLogueo
                               orderby unU.FechaHora descending
                               select unU).ToList<Mensaje>();

        return lista;
    }
    public static List<Mensaje> ListarRecibidosTipoFecha(Usuario usuario, TipodeMensaje tipo = null, DateTime fecha = new DateTime())
    {
        VEcontext.Usuario.ToList();
        VEcontext.TipodeMensaje.ToList();

        List<Mensaje> lista = (from unU in VEcontext.Mensaje
                               from unR in unU.Reciben
                               where unR.UsuarioLogueo == usuario.UsuarioLogueo
                               orderby unU.FechaHora descending
                               select unU).ToList<Mensaje>();

        if (tipo != null && fecha != new DateTime())
        {
            List<Mensaje> listaCompleta = (from unU in lista
                                           where unU.TipodeMensaje.Codigo == tipo.Codigo &&
                                           unU.FechaHora.Date == fecha.Date
                                           select unU).ToList<Mensaje>();

            return listaCompleta;
        }
        else if (tipo != null && fecha == new DateTime())
        {
            List<Mensaje> listaTipos = (from unU in lista
                                        where unU.TipodeMensaje.Codigo == tipo.Codigo
                                        select unU).ToList<Mensaje>();

            return listaTipos;
        }
        else
        {
            List<Mensaje> listaFecha = (from unU in lista
                                        where unU.FechaHora.Date == fecha.Date
                                        select unU).ToList<Mensaje>();

            return listaFecha;
        }
    }
    public static List<Mensaje> ListaEnviadosTipoFecha(Usuario usuario, TipodeMensaje tipo = null, DateTime fecha = new DateTime())
    {
        VEcontext.Usuario.ToList();
        VEcontext.TipodeMensaje.ToList();

        List<Mensaje> lista = (from unU in VEcontext.Mensaje
                               where unU.UsuarioLogueo == usuario.UsuarioLogueo
                               orderby unU.FechaHora descending
                               select unU).ToList<Mensaje>();

        if (tipo != null && fecha != new DateTime())
        {
            List<Mensaje> listaCompleta = (from unU in lista
                                           where unU.TipodeMensaje.Codigo == tipo.Codigo &&
                                           unU.FechaHora.Date == fecha.Date
                                           select unU).ToList<Mensaje>();

            return listaCompleta;
        }
        else if (tipo != null && fecha == new DateTime())
        {
            List<Mensaje> listaTipos = (from unU in lista
                                        where unU.TipodeMensaje.Codigo == tipo.Codigo
                                        select unU).ToList<Mensaje>();

            return listaTipos;
        }
        else
        {
            List<Mensaje> listaFecha = (from unU in lista
                                        where unU.FechaHora.Date == fecha.Date
                                        select unU).ToList<Mensaje>();

            return listaFecha;
        }
    }
    public static int CantidadUsuarios()
    {
        int cantidad = VEcontext.Usuario.ToList().Count();

        return cantidad;
    }
    public static int CantidadMensajesEnviados()
    {
        int cantidad = VEcontext.Mensaje.ToList().Count();

        return cantidad;
    }
    
    public static XmlDocument CantidadTipos()
    {
        XmlDocument _Documento = new XmlDocument();
        _Documento.LoadXml("<?xml version='1.0' encoding='utf-8' ?> <Estadisticas> </Estadisticas>");
        XmlNode _raiz = _Documento.DocumentElement;

        List<TipodeMensaje> lista = VEcontext.TipodeMensaje.ToList();
        
        TipodeMensaje tipo = null;

        foreach (TipodeMensaje v in lista)
        {
            tipo = v;
            XmlNode _tiposMensaje = _Documento.CreateNode(XmlNodeType.Element, "Tipos", "");

            string cant = (from unM in VEcontext.Mensaje                           
                           where unM.TipodeMensaje.Codigo == tipo.Codigo
                           select unM).Count().ToString();

            _tiposMensaje.InnerText = cant;
            XmlAttribute attribute = _Documento.CreateAttribute("TipoM");
            attribute.Value = tipo.Nombre;
            _tiposMensaje.Attributes.Append(attribute);
            _raiz.AppendChild(_tiposMensaje);
        }

        return _Documento;
    }

    public static List<object> Destinatarios(Mensaje M)
    {
        List<object> lista = (from unM in VEcontext.Mensaje
                              where unM.Codigo == M.Codigo
                              from Rec in unM.Reciben
                              select Rec).ToList<object>();

        return lista;
    }
}