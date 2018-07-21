using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Nacionales : Viajes
    {
        //Atributos
        private int _paradas;


        //Propiedades
        public int Paradas
        {
            get { return _paradas; }

            set
            {
                if (value >= 0)
                    _paradas = value;
                else
                    throw new Exception("El número de paradas no es válido");
            }
        }


        //Constructor
        public Nacionales(int pNumero, Companias pCompania, Terminales pTerminal, DateTime pFecha_partida, DateTime pFecha_arribo, int pAsientos, Empleados pEmpleado, int pParadas)
            : base(pNumero, pCompania, pTerminal, pFecha_partida, pFecha_arribo, pAsientos, pEmpleado)
        {
            Paradas = pParadas;
        }
    }
}
