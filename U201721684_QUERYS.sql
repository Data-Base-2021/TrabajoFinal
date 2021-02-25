/*
Sacar todos los empleados por DNI que tienen la fecha final de contrato en un determinado rango
y que pertenescan a una determinada sede, se requiere mostrar nombre del empleado,nombre de la sede,y la fecha final de contrato.
*/

ALTER PROCEDURE RangoFechaFinalcontratoysede
@RFECHAINICIAL DATETIME,
@RFECHAFINAL DATETIME ,
@SEDE NVARCHAR(30)
AS
SELECT p.CPersona,p.NPersona,s.NSede,e.DFinalContrato FROM 
Sede s join Empleado e on s.CSede=e.CSede
join Persona p on e.CEmpleado=p.CPersona
join TurnoTrabajo t on e.CTurno=t.CTurno where  e.DFinalContrato between @RFECHAINICIAL and @RFECHAFINAL and s.NSede=@SEDE 

EXEC RangoFechaFinalcontratoysede '2020-01-10','2022-06-15','Plaza del Sol'



/*La empresa requiere que cada vez que un empleado quiera editar el nombre de un cliente
dispare un error , no permitiendo que se ejecute esta accion*/

CREATE TRIGGER nopermitecambiarnombrecliente 
ON Persona
FOR UPDATE
AS
IF UPDATE(NPersona) 
BEGIN
RAISERROR (15600,-1,-1,'No puede cambiar el nombre del cliente');
ROLLBACK TRANSACTION
END

/*Probando que no se permite actualizar el nombre*/
UPDATE Persona
SET NPersona = 'pepe'
WHERE CPersona = "14952608"




/*La empresa mostrar el codigo de la persona,nombre,y la avenida donde vive 
solo pasandole como parametro el DNI*/
CREATE FUNCTION listarpersonapordni (@cpersona  int)
RETURNS @persona TABLE
(
CPersona int, NPersona nvarchar(50),TAvenida text
)
AS
BEGIN
INSERT @persona SELECT CPersona,NPersona,TAvenida FROM Persona
WHERE CPersona=@cpersona
RETURN
END
 

SELECT * FROM listarpersonapordni(14952608)




/*La empresa requiere mostrar todos los productos que abastece a la empresa por un determinado 
proveedor, se le enviara como parametro el codigo de proveedor, se debe mostrar el codigo del proveedor
,nombre del proveedor, codigo del producto y el nombre del producto*/


CREATE FUNCTION listarproductorporproveedor(@codigoproveedor int)
RETURNS TABLE
AS
RETURN
(
 select p.CProveedor,p.NProveedor,pr.CProducto,pr.NProducto from Proveedor p
join Compra_Proveedor cp on p.CProveedor=cp.CProveedor
join Detalle_Compra dc on dc.CCompra=cp.CCompra
join Producto pr on dc.CProducto=  pr.CProducto where p.CProveedor=@codigoproveedor
group by p.CProveedor,p.NProveedor,pr.CProducto,pr.NProducto
)
 
SELECT * FROM listarproductorporproveedor(103)



/*La empresa quiere saber que distritos son los que el monto total de venta 
son superiores al promedio del monto total por distrito*/

create view vw_promediomontoventa as
select d.NDistrito,SUM(pv.MParcial*pv.QProducto) 'monto' from 

Distrito d join VentaVirtual vv on d.CDistrito=vv.CDistrito
join Venta v on vv.CVentaVirtual=v.CVenta
join ProductoVenta pv on v.CVenta=pv.CVenta
group by d.NDistrito


select 
AVG(vw.monto)
from 

vw_promediomontoventa as vw

select vw.NDistrito,vw.monto from vw_promediomontoventa as vw where vw.monto>(select 
AVG(vw_promediomontoventa.monto)
from 

vw_promediomontoventa)
















