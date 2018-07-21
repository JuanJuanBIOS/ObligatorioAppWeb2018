using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;
using Logica.Interfaces;
using Persistencia.Interfaces;
using Persistencia;

namespace Logica
{
    internal class LogicaViajes : ILogicaViajes
    {
        //Singleton
        private static LogicaViajes _instancia = null;
        private LogicaViajes() { }

        public static LogicaViajes GetInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new LogicaViajes();
            }

            return _instancia;
        }


        //Operaciones
        public Viajes Buscar_Viaje(int pCodViaje)
        {
            Viajes unViaje = null;

            IPersistenciaNacionales FNacionales = FabricaPersistencia.getPersistenciaNacionales();

            unViaje = FNacionales.Buscar_Viaje(pCodViaje);

            if (unViaje == null)
            {
                IPersistenciaInternacionales FInternacionales = FabricaPersistencia.getPersistenciaInternacionales();
                unViaje = FInternacionales.Buscar_Viaje(pCodViaje);
            }

            return unViaje;
        }
    }
}
