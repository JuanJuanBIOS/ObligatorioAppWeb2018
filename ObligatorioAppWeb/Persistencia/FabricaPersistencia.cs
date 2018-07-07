using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Persistencia
{
    public class FabricaPersistencia
    {
        public static IPersistenciaEmpleado getPersistenciaEmpleado()
        {
            return (PersistenciaEmpleado.GetInstancia());
        }

<<<<<<< HEAD
<<<<<<< HEAD
        public static IPersistenciaTerminales getPersistenciaTerminal()
        {
            return (PersistenciaTerminales.GetInstancia());
=======
        public static IPersistenciaCompania getPersistenciaCompania()
        {
            return (PersistenciaCompania.GetInstancia());
>>>>>>> 843afe1e700de0628470ab0457913b4469e3b7eb
=======
        public static IPersistenciaCompania getPersistenciaCompania()
        {
            return (PersistenciaCompania.GetInstancia());
>>>>>>> 843afe1e700de0628470ab0457913b4469e3b7eb
        }
    }
}
