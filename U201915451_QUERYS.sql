/* 1. La empresa desea brindar unos descuentos de productos comprados por los usuarios cuyas
compras sean mayores o iguales a un monto determinado en un periodo de tiempo, ademas del
producto mas caro que compró de dicha compra.Se desea saber el codigo del usuario,su nombre,
su apellido,el nombre del producto y su monto*/

create function DescuentoCompra(@fecha_inicio date, @fecha_final date, @monto money)
    returns table
        as
        return
            (
                select u.CUsuario,
                       p.NPersona,
                       p.NApellidoPaterno,
                       v.DVenta,
                       SUM(V.MTotal)                   'Monto',
                       pr.NProducto,
                       SUM(pv.QProducto * pv.MParcial) 'MontoxProducto'
                from Persona p
                         join Usuario u on p.CPersona = u.CUsuario
                         join Venta v on v.CPersona = u.CUsuario
                         join ProductoVenta pv on pv.CVenta = v.CVenta
                         join Producto pr on pr.CProducto = pv.CProducto
                where v.DVenta between @fecha_inicio and @fecha_final
                group by u.CUsuario, p.NPersona, p.NApellidoPaterno, v.DVenta, pr.NProducto, pv.MParcial
                having (SUM(V.MTotal) >= @monto)
                   and (SUM(pv.QProducto * pv.MParcial)) >= (SUM(v.MTotal) / 2)
            )


select *
from DescuentoCompra('2019/06/01', '2020/06/01', 600)

/*2. El personal de logistica quiere saber la cantidad de invitados que han llevado 
los usuarios de todas las sedes. Asi ver la opcion de hacer una ampliacion de la 
sede o poner otra en el distrito, esto solo se cumplira si la cantidad de invitados
es mayor a un numero puesto por la empresa. Se pide el codigo de la sede,
el nombre de la sede ,el nombre distrito de la sede y la cantidad de invitados por sede */

create function Invitados(@cantidad int)
    returns table
        as
        return
            (
                select s.CSede, s.NSede, d.NDistrito, COUNT(ri.CInvitado) 'Q_Invitado'
                from Sede s
                         join Distrito d on s.Distrito_CDistrito = d.CDistrito
                         join Inscripcion i on i.CSede = s.CSede
                         join Usuario u on i.CUsuario = u.CUsuario
                         join ReservaHorario rh on rh.CUsuario = u.CUsuario
                         join RegistroInvitado ri on ri.CReservaHorario = rh.CReservaHorario
                group by s.CSede, s.NSede, d.NDistrito
                having COUNT(ri.CInvitado) > @cantidad
            )
select *
from Invitados(5)

/* 3. La empresa decide invertir mas en la venta, pero se sabe hay 2 tipos de 
ventas. La empresa te pide que muestres cual de las dos ventas ha tenido mas
ganancia desde que se creo la empresa y la diferencia entre las 2 ventas */

Create VIEW vw_vp_comp as
select vp.CVentaPresencial, SUM(V.MTotal) 'Monto', v.DVenta, v.CVenta
from Venta v
         join VentaPresencial vp on v.CVenta = vp.CVentaPresencial
group by vp.CVentaPresencial, v.DVenta, v.CVenta

Create VIEW vw_vv_comp as
select vv.CVentaVirtual, SUM(V.MTotal) 'Monto', v.DVenta, v.CVenta
from Venta v
         join VentaVirtual vv on v.CVenta = vv.CVentaVirtual
group by vv.CVentaVirtual, v.DVenta, v.CVenta

select SUM(vw.Monto) 'Resultados'
from vw_vp_comp vw
UNION
select SUM(vw1.Monto)
from vw_vv_comp vw1
UNION
select (select SUM(vw.Monto)
        from vw_vp_comp vw)
           -
       (select SUM(vw1.Monto)
        from vw_vv_comp vw1)

/* 4. La empresa quiere saber las marcas de productos que superen el promedio monto de ventas realizados
en un rango de tiempo puestos por la empresa.Esto ayudara en las futuras promociones que se
haran a las marcas. De esto te piden el codigo y nombre de marca, el modelo 
*/

CREATE function MarcaProd(@fecha_inicio date, @fecha_final date)
    returns table
        as
        return
            (
                select m.CMarca, m.NMarca, mo.NModelo, SUM(pv.QProducto) 'Ventas'
                from Marca m
                         join Modelo mo on m.CMarca = mo.CMarca
                         join Producto p on p.CModelo = mo.CModelo
                         join ProductoVenta pv on pv.CProducto = p.CProducto
                         join Venta v on v.CVenta = pv.CVenta
                where v.DVenta between @fecha_inicio and @fecha_final
                group by m.CMarca, m.NMarca, mo.NModelo
                having SUM(pv.QProducto) >= (Select MAX(nv.Ventas)
                                             FROM (
                                                      select m.CMarca, m.NMarca, mo.NModelo, SUM(pv.QProducto) 'Ventas'
                                                      from Marca m
                                                               join Modelo mo on m.CMarca = mo.CMarca
                                                               join Producto p on p.CModelo = mo.CModelo
                                                               join ProductoVenta pv on pv.CProducto = p.CProducto
                                                               join Venta v on v.CVenta = pv.CVenta
                                                      where v.DVenta between @fecha_inicio and @fecha_final
                                                      group by m.CMarca, m.NMarca, mo.NModelo) AS nv)
            )

select *
from MarcaProd('2018/01/01', '2019/12/31')

/* 5. La empresa es consciente de los riesgo que corre los repartidores
a la hora de repartir por todas las partes de Lima, por eso decidieron
darle un bono al repartidor que repartió la mayor cantidad de productos.
Pero para esto la empresa te pide los datos como su código, su nombre y
la los productos repartidos*/

create view vw_repar_venta as
select r.CRepartidor, p.NPersona, Sum(pv.QProducto) 'Venta'
from Persona p
         join Repartidor r on p.CPersona = r.CRepartidor
         join VentaVirtual vv on vv.CRepartridor = r.CRepartidor
         join Venta v on v.CVenta = vv.CVentaVirtual
         join ProductoVenta pv on pv.CVenta = v.CVenta
group by r.CRepartidor, p.NPersona

select *
from vw_repar_venta vw
where vw.Venta = (select MAX(vw1.Venta)
                  from vw_repar_venta vw1)