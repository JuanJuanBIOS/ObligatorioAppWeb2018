using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Empleados
    {
        //Atributos
        private string _cedula;
        private string _pass;
        private string _nombre;


        //Propiedades
        public string Cedula
        {
            get { return _cedula; }

            set
            {
                try
                {
                    //Intento convertir el número de cédula en un Int
                    int ced = Convert.ToInt32(value);
                    
                    //Verifico que el dígito verificador sea el que debe ser
                    int digver = ced % 10;
                    int dig1 = (ced - digver) % 100;
                    int dig2 = (ced - digver - dig1 * 10) % 1000;
                    int dig3 = (ced - digver - dig1 * 10 - dig2 * 1000) % 10000;
                    int dig4 = (ced - digver - dig1 * 10 - dig2 * 1000 - dig3 * 10000) % 100000;
                    int dig5 = (ced - digver - dig1 * 10 - dig2 * 1000 - dig3 * 10000 - dig4 * 100000) % 1000000;
                    int dig6 = (ced - digver - dig1 * 10 - dig2 * 1000 - dig3 * 10000 - dig4 * 100000 - dig5 * 1000000) % 10000000;
                    int dig7 = (ced - digver - dig1 * 10 - dig2 * 1000 - dig3 * 10000 - dig4 * 100000 - dig5 * 1000000 - dig6 * 10000000) % 100000000;
                    
                    int verificador = dig7 * 8 + dig6 * 1 + dig5 * 2 + dig4 * 3 + dig3 * 4 + dig2 * 7 + dig1 * 6;

                    //Si el dígito verificador es correcto lo asigno, de lo contrario devuelvo un error
                    if (digver == verificador)
                    {
                        _cedula = value;
                    }

                    else
                    {
                        throw new Exception("El número de cédula ingresado no es correcto");
                    }

                }
                catch
                {
                    throw new Exception("El número de cédula ingresado no es correcto");
                }
            }
        }






    }
}
