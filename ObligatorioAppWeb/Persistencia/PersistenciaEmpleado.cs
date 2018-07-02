using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia
{
    internal class PersistenciaEmpleado : IPersistenciaEmpleado
    {
        //Singleton
        private static PersistenciaEmpleado _instancia = null;

        private PersistenciaEmpleado() { }

        public static PersistenciaEmpleado GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new PersistenciaEmpleado();
            }

            return _instancia;
        }


        //Operaciones
        public Empleados Login(string pCed, string pPass)
        {
            //ACÁ FALTA HACER LA CONEXIÓN CON LA BASE DE DATOS, ETC, ETC
            return null;
        }
    }
}
