<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ABMViajesInternacionales.aspx.cs" Inherits="ABMViajesInternacionales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PaginaPrincipal" runat="server">



    <h2 align="center">
        <asp:Label ID="LbSubt" runat="server" 
            Text="Mantenimiento de Viajes Internacionales"></asp:Label>
    </h2>
<p>
    Número:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TBNumero" runat="server"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="BtnBuscar" runat="server" Text="Buscar" onclick="BtnBuscar_Click" 
       />
</p>
    <p dir="ltr" style="margin-left: 40px">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="LblError" runat="server" ForeColor="Red"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
    <table style="width: 100%">
        <tr>
            <td style="width: 179px">
                Compañía:
            </td>
            <td colspan="13">
                <asp:DropDownList ID="DDLCompania" runat="server" Width="240px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 179px">
                Terminal:
            </td>
            <td colspan="13">
                <asp:DropDownList ID="DDLTerminal" runat="server" Enabled="False" Width="240px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
                <td style="width: 179px">
                    &nbsp;</td>
                <td class="style10" colspan="2">
                    &nbsp;</td>
                <td colspan="3">
                    &nbsp;</td>
                <td class="style9" colspan="1">
                    &nbsp;</td>
                <td class="style9">
                    &nbsp;</td>
                <td colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style7" style="width: 179px">
                    <asp:Label ID="LbFechaPartida" runat="server" Text="Fecha Partida"></asp:Label>
                    <br />
                    <asp:TextBox ID="TBFechaPartida" runat="server" Enabled="False"></asp:TextBox>
                </td>
                <td class="style10" colspan="6">
                    <asp:Calendar ID="CalFechaPartida" runat="server" Enabled="False" 
                        onselectionchanged="CalFechaPartida_SelectionChanged"></asp:Calendar>
                </td>
                <td class="style9">
                    <br />
                </td>
                <td class="style9" style="width: 232px">
                    <br />
                </td> 
                <td class="style9">
                    <asp:Label ID="LbFechaArribo" runat="server" Text="Fecha Arribo"></asp:Label>
                    <br />
                    <asp:TextBox ID="TBFechaArribo" runat="server" Enabled="False"></asp:TextBox>
                </td> 
                <td colspan="2" align="left" style="width: 179px">
                    <br />
                    <asp:Calendar ID="CalFechaArribo" runat="server" Enabled="False"></asp:Calendar>
                </td>
                <td align="left" >
                    &nbsp;</td>
            </tr>
        <tr>
            <td style="width: 179px">
                <asp:Label ID="LBHoraPartida" runat="server" Text="Hora Partida"></asp:Label>
            </td>
            <td colspan="7">
                <asp:DropDownList ID="DDLHoraPartida" runat="server" Enabled="False" 
                    Width="70px">
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                </asp:DropDownList>
                &nbsp;:
                <asp:DropDownList ID="DDLMinutosPartida" runat="server" Enabled="False" 
                    Width="70px">
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                    <asp:ListItem>24</asp:ListItem>
                    <asp:ListItem>25</asp:ListItem>
                    <asp:ListItem>26</asp:ListItem>
                    <asp:ListItem>27</asp:ListItem>
                    <asp:ListItem>28</asp:ListItem>
                    <asp:ListItem>29</asp:ListItem>
                    <asp:ListItem>30</asp:ListItem>
                    <asp:ListItem>31</asp:ListItem>
                    <asp:ListItem>32</asp:ListItem>
                    <asp:ListItem>33</asp:ListItem>
                    <asp:ListItem>34</asp:ListItem>
                    <asp:ListItem>35</asp:ListItem>
                    <asp:ListItem>36</asp:ListItem>
                    <asp:ListItem>37</asp:ListItem>
                    <asp:ListItem>38</asp:ListItem>
                    <asp:ListItem>39</asp:ListItem>
                    <asp:ListItem>40</asp:ListItem>
                    <asp:ListItem>41</asp:ListItem>
                    <asp:ListItem>42</asp:ListItem>
                    <asp:ListItem>43</asp:ListItem>
                    <asp:ListItem>44</asp:ListItem>
                    <asp:ListItem>45</asp:ListItem>
                    <asp:ListItem>46</asp:ListItem>
                    <asp:ListItem>47</asp:ListItem>
                    <asp:ListItem>48</asp:ListItem>
                    <asp:ListItem>49</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>51</asp:ListItem>
                    <asp:ListItem>52</asp:ListItem>
                    <asp:ListItem>53</asp:ListItem>
                    <asp:ListItem>54</asp:ListItem>
                    <asp:ListItem>55</asp:ListItem>
                    <asp:ListItem>56</asp:ListItem>
                    <asp:ListItem>57</asp:ListItem>
                    <asp:ListItem>58</asp:ListItem>
                    <asp:ListItem>59</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:Label ID="LBHoraArribo" runat="server" Text="Hora Arribo"></asp:Label>
            </td>
            <td colspan="2">
                <asp:DropDownList ID="DDLHoraArribo" runat="server" Enabled="False" 
                    Width="70px">
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                </asp:DropDownList>
                &nbsp;:
                <asp:DropDownList ID="DDLMinutosArribo" runat="server" Enabled="False" 
                    Width="70px">
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                    <asp:ListItem>24</asp:ListItem>
                    <asp:ListItem>25</asp:ListItem>
                    <asp:ListItem>26</asp:ListItem>
                    <asp:ListItem>27</asp:ListItem>
                    <asp:ListItem>28</asp:ListItem>
                    <asp:ListItem>29</asp:ListItem>
                    <asp:ListItem>30</asp:ListItem>
                    <asp:ListItem>31</asp:ListItem>
                    <asp:ListItem>32</asp:ListItem>
                    <asp:ListItem>33</asp:ListItem>
                    <asp:ListItem>34</asp:ListItem>
                    <asp:ListItem>35</asp:ListItem>
                    <asp:ListItem>36</asp:ListItem>
                    <asp:ListItem>37</asp:ListItem>
                    <asp:ListItem>38</asp:ListItem>
                    <asp:ListItem>39</asp:ListItem>
                    <asp:ListItem>40</asp:ListItem>
                    <asp:ListItem>41</asp:ListItem>
                    <asp:ListItem>42</asp:ListItem>
                    <asp:ListItem>43</asp:ListItem>
                    <asp:ListItem>44</asp:ListItem>
                    <asp:ListItem>45</asp:ListItem>
                    <asp:ListItem>46</asp:ListItem>
                    <asp:ListItem>47</asp:ListItem>
                    <asp:ListItem>48</asp:ListItem>
                    <asp:ListItem>49</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>51</asp:ListItem>
                    <asp:ListItem>52</asp:ListItem>
                    <asp:ListItem>53</asp:ListItem>
                    <asp:ListItem>54</asp:ListItem>
                    <asp:ListItem>55</asp:ListItem>
                    <asp:ListItem>56</asp:ListItem>
                    <asp:ListItem>57</asp:ListItem>
                    <asp:ListItem>58</asp:ListItem>
                    <asp:ListItem>59</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 179px">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="2" style="width: 75px">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="3">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 179px; height: 26px;">
                Cantidad de Asientos: </td>
            <td colspan="13" style="height: 26px">
                <asp:TextBox ID="TBCantAsientos" runat="server" Enabled="False" Width="66px" 
                    MaxLength="3"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 179px">
                Servicio a bordo: </td>
            <td colspan="13">
                <asp:DropDownList ID="DDLServicio" runat="server" Enabled="False">
                    <asp:ListItem>No</asp:ListItem>
                    <asp:ListItem>Si</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 179px">
                Documentación: </td>
            <td colspan="13">
                <asp:TextBox ID="TBDocumentacion" runat="server" Enabled="False" 
                    TextMode="MultiLine" Width="257px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 179px">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="2" style="width: 75px">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="3">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" style="width: 179px" >
                &nbsp;</td>
            <td align="center" >
                <asp:Button ID="BtnAlta" runat="server" Text="Alta" Enabled="False" 
                    />
            </td>
            <td align="center" style="width: 117px" >
                <asp:Button ID="BtnModificar" runat="server" Text="Modificar"  Enabled="False" 
                    />
            </td>
            <td align="center" style="width: 22px" >
                &nbsp;</td>
            <td align="center" colspan="4" >
                <asp:Button ID="BtnEliminar" runat="server" Text="Eliminar"  Enabled="False" 
                     />
            </td>
            <td align="center" colspan="2" >
                <asp:Button ID="BtnLimpiar" runat="server"
                    Text="Limpiar formulario" onclick="BtnLimpiar_Click" />
            </td>
            <td align="center" style="width: 268435440px" >
                &nbsp;</td>
            <td align="left" style="width: 23px" colspan="2" >
                &nbsp;</td>
            <td align="left" style="width: 543px" >
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

