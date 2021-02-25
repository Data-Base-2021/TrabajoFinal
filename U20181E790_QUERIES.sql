--****************************************************************************************************************
/*1*/--==================================================================================*
--	El gerente desea saber las sedes y los horarios en la que la cantidad de         *
--      asistentes es mayor o menor que el numero ingresado.                             *
--=======================================================================================*

create view vw_QAsistentes_Hora_Sede_ as
select s.CSede, horario = datepart(hour, RH.DRegistro), QAsistentes= count(RH.CReservaHorario)
from Sede s
         join ReservaHorario RH on s.CSede = RH.CSede
group by s.CSede, datepart(hour, RH.DRegistro);


create Procedure pr_CalcularCantidadAsistentes @valor int,
                                               @maxmin int
as
    if @maxmin = 1
        begin
            select vQAHS.CSede, vQAHS.horario, vQAHS.QAsistentes
            from vw_QAsistentes_Hora_Sede_ vQAHS
            where vQAHS.QAsistentes > @valor
        end
    else
        begin
            select vQAHS.CSede, vQAHS.horario, vQAHS.QAsistentes
            from vw_QAsistentes_Hora_Sede_ vQAHS
            where vQAHS.QAsistentes < @valor
        end


    exec pr_CalcularCantidadAsistentes 2, 0


 ------********************************************************************************************************************
/*2*/--=============================================================================================*
    --	El gerente desea conocer el o los productos más rentables.        *
    -- Por ello, dado un rango de fechas y un producto en específico, se deberá mostrar el          *
    -- precio promedio general y el precio promedio durante las fechas ingresadas.                  *
    --================================================================================================


    CREATE view vw_montoPorProducto_ as
    select DC.CProducto, montoTotalxproducto = sum(DC.MParcial)
    from Compra_Proveedor cp
             join Detalle_Compra DC on cp.CCompra = DC.CCompra
             join Producto P on P.CProducto = DC.CProducto
    group by DC.CProducto;

    create function fn_ObtenerRentabilidad_(@cprod int, @date1 date, @date2 date)
        returns table
            as
            return
                (
                    select                       vw.CProducto,
                                                 P.NProducto,
                        PrecioPromedioFiltrado = avg(DC.MParcial),
                                                 'PRECIO FILTRADO' as tipodeBusqueda
                    from vw_montoPorProducto_ vw
                             join Detalle_Compra DC on vw.CProducto = DC.CProducto
                             join Producto P on DC.CProducto = P.CProducto
                             join Compra_Proveedor CP on CP.CCompra = DC.CCompra
                    where vw.CProducto = @cprod
                      and CP.DCompra between @date1 and @date2
                    group by vw.CProducto, P.NProducto
                    UNION
                    select               vw1.CProducto,
                                         P1.NProducto,
                        PrecioPromedio = avg(DC1.MParcial),
                                         'PRECIO GENERAL' as tipodeBusqueda
                    from vw_montoPorProducto_ vw1
                             join Detalle_Compra DC1 on vw1.CProducto = DC1.CProducto
                             join Producto P1 on P1.CProducto = DC1.CProducto
                    where vw1.CProducto = @cprod
                    group by vw1.CProducto, P1.NProducto
                )

select *
from dbo.fn_ObtenerRentabilidad_(114, '2018/10/19', '2019/11/11');

--***************************************************************************************************************************************

/*3*/
   --============================================================================================================*
   -- 5)	El gerente desea mostrar el monto total gastado en campañas.                                       *
    --Para ello, se debe mostrar en una tabla invertida, el año, el mes y monto total gastado.                 *
--================================================================================================================

    create view vw_mONTOtOTALcAMPAÑAS AS
    select año = datepart(year, c.DInicio), mes = datepart(month, c.DInicio), monto = sum(c.MInvertido)
    from Campania c
    group by datepart(year, c.DInicio), datepart(month, c.DInicio);
------------------------------
    create procedure pr_Pivot_MontoCampañas_
    as
    select *
    from (
             select *
             from vw_mONTOtOTALcAMPAÑAS
         ) [vmOOOLA*]
             pivot (
             sum(monto)
             for mes in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
             ) P


        exec pr_Pivot_MontoCampañas_


        create procedure pr_PrimervALORmONTOcAMPAÑA_
        as
        declare
            mycursor cursor scroll
                for select año, mes, monto
                    from vw_mONTOtOTALcAMPAÑAS
            open mycursor
            fetch first from mycursor
            close mycursor
            deallocate mycursor
            create procedure pr_ultimovalorcampaña_
            as
            declare
                micursor cursor scroll
                    for select año, mes, monto
                        from vw_mONTOtOTALcAMPAÑAS
                open micursor
                fetch last from micursor
                close micursor
                deallocate micursor


                exec pr_PrimervALORmONTOcAMPAÑA_
                exec pr_ultimovalorcampaña_

--*********************************************************************
/*4*/--======================================================================================================*
--	Se solicita automatizar el stock de los productos. Por ello, se debe implementar un trigger que    *
-- sume la cantidad de compras y reste la cantidad de ventas al stock.                                     *
--============================================================================================================*

            select *
            from Producto;

                create trigger tr_ActualizarStockCompras
                    on Detalle_Compra
                    for insert
                    as
                    set nocount on
                    update Producto
                    set Producto.stock = Producto.stock + inserted.QProducto
                    from inserted
                             join Producto on Producto.CProducto = inserted.CProducto;

                    create trigger tr_ActualizarStockVentas
                        on ProductoVenta
                        for insert
                        as
                        set nocount on
                        update Producto
                        set Producto.stock = Producto.stock - inserted.QProducto
                        from inserted
                                 join Producto on Producto.CProducto = inserted.CProducto;

                        INSERT INTO Compra_Proveedor
                        VALUES (0475, 18610, 456, '2019-11-10', 400)
                        insert into Detalle_Compra
                        values (113, 456, 8, 50)
                        insert into Venta
                        values (4, 70675089, 100, 1, '2020-02-03')
                        insert into ProductoVenta
                        values (115, 4, 40, 8)

--************************************************************************************************************************
/*5*/   --===============================================================================================================================*
           --   4)	  El gerente quiere que se registren los productos que son modificados.                                                *
            --         Guardar en una tabla el producto, con los valores antiguos y lo nuevos.                                             *
             --       Con la información generada, mostrar cual es el producto con mayor inestabilidad durante determinadas fechas.        *
--========================================================================================================================================

                        create table HistorialProductos
                        (
                            Dmodificacion       date,
                            UsuarioModificacion varchar(30),
                            cproducto           int,
                            ant_nproducto       varchar(30),
                            new_nproducto       varchar(30),
                            ant_precio          money,
                            new_precio          money
                        )
                        create trigger tr_HistorialProducto
                            on Producto
                            after update
                            as
                            set nocount on
                        begin
                            --if update(NProducto or MPrecio or CProducto )
                            --begin
                            declare @prevPrice money
                            declare @newPrice money
                            declare @code int
                            declare @prevName varchar(30)
                            declare @newName varchar(30)

                            select @prevPrice = d.MPrecio,
                                   @newPrice = i.MPrecio,
                                   @Code = i.CProducto,
                                   @prevName = d.NProducto,
                                   @newName = i.NProducto
                            from deleted d
                                     inner join inserted i on d.CProducto = i.CProducto
                            insert into HistorialProductos
                            values (getdate(), system_user, @Code, @prevName, @newName, @prevPrice, @newPrice)
                            --end
                        end
                            create view vw_vecesqunproductocambia_ as
                            select hp.cproducto, count(hp.cproducto) as vecesModificado
                            from HistorialProductos hp
                            group by hp.cproducto;

                            create procedure pr_productoQuemascambio_ @maxmin char
                            as
                                if @maxmin = 's'
                                    begin
                                        select vecesModificado = max(vecesModificado), v2.cproducto
                                        from vw_vecesqunproductocambia_ v2
                                        group by v2.cproducto
                                        having max(vecesModificado) = all (
                                            select max(v3.vecesModificado)
                                            from vw_vecesqunproductocambia_ v3
                                        )
                                    end
                                else
                                    begin
                                        select vecesModificado= min(v4.vecesModificado), v4.cproducto
                                        from vw_vecesqunproductocambia_ v4
                                        group by v4.cproducto
                                        having min(v4.vecesModificado) = all (
                                            select min(v5.vecesModificado)
                                            from vw_vecesqunproductocambia_ v5
                                        )
                                    end


                            select *
                            from Producto;

                            select *
                            from HistorialProductos;

                                truncate table HistorialProductos;


                            update Producto
                            set NProducto='Cell-Tech'
                            where CProducto = 113
                            update Producto
                            set NProducto='bigmass'
                            where CProducto = 114
                            update Producto
                            set NProducto='Carnivoro'
                            where CProducto = 115
                            update Producto
                            set MPrecio = 12000
                            where CProducto = 113


                                exec pr_productoQuemascambio_ 's'


