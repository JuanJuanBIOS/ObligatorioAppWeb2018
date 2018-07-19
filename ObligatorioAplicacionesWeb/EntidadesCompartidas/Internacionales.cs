using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Internacionales : Viajes
    {
        //Atributos
        private bool _servicio;
        private string _documentacion;

        //Propiedades
        public bool Servicio
        {
            get { return _servicio; }

            set { _servicio = value; }
        }

        public string Documentacion
        {
            get { return _documentacion; }

            set
            {
                if (value.Length <= 200)
                {
                    _documentacion = value;
                }
                else
                {
                    throw new Exception("La descripción de la documentación no puede contener más de 200 caracteres");
                }
            }
        }


        //Constructor
        public Internacionales(int pNumero, Companias pCompania, Terminales pTerminal, DateTime pFecha_partida, DateTime pFecha_arribo, int pAsientos, Empleados pEmpleado, bool pServicio, string pDoocumentacion)
            : base(pNumero, pCompania, pTerminal, pFecha_partida, pFecha_arribo, pAsientos, pEmpleado)
        {
            Servicio = pServicio;
            Documentacion = pDoocumentacion;
        }
    }
}
