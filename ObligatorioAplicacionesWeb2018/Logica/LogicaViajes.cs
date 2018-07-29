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

        public void Alta_Viaje(Viajes unViaje)
        {
            if(unViaje is Internacionales)
            {
                IPersistenciaInternacionales FInternacional = FabricaPersistencia.getPersistenciaInternacionales();

                FInternacional.Alta_Internacional((Internacionales)unViaje);
            }

            else
            {
                IPersistenciaNacionales FNacional=FabricaPersistencia.getPersistenciaNacionales();

                FNacional.Alta_Nacional((Nacionales)unViaje);
            }
        }

        public void Modificar_Viaje(Viajes unViaje)
        {
            if (unViaje is Internacionales)
            {
                IPersistenciaInternacionales FInternacional = FabricaPersistencia.getPersistenciaInternacionales();

                FInternacional.Modificar_Internacional((Internacionales)unViaje);
            }

            else
            {
                IPersistenciaNacionales FNacional=FabricaPersistencia.getPersistenciaNacionales();

                FNacional.Modificar_Nacional((Nacionales)unViaje);
            }
        }

        public void Eliminar_Viaje(Viajes unViaje)
        {
            if (unViaje is Internacionales)
            {
                IPersistenciaInternacionales FInternacional = FabricaPersistencia.getPersistenciaInternacionales();

                FInternacional.Eliminar_Internacional((Internacionales)unViaje);
            }

            else
            {
                IPersistenciaNacionales FNacional=FabricaPersistencia.getPersistenciaNacionales();

                FNacional.Eliminar_Nacional((Nacionales)unViaje);
            }
        }
    }
}
