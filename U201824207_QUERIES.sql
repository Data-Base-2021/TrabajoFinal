--1--

/*El gerente del gimnasio quiere apertura nuevas sedes y saber si incluir tienda física dentro de las mismas. 
Para ello, se debe extraer la información de los distritos y sus sedes y la cantidad de usuarios que van a esa sede. 
Asimismo, se debe mostrar las sedes actuales que existen en dichos distritos y el monto acumulado del usuario. 
De esta manera se decidirá si incluir tienda en la sede a apertura.*/

create procedure pr_cualquiercosa_ as
begin
    select s.NSede, d.NDistrito, Count(i.CEmpleado) 'cantidad de usuarios', sum(pl.MPrecio) 'Monto'
    from Distrito d
             join Sede s on d.CDistrito = s.Distrito_CDistrito
             join PlanSede pl on s.CSede = pl.CSede
             join Inscripcion i on i.CPlan = pl.CPlan

    group by s.NSede, d.NDistrito
end

    exec pr_cualquiercosa_


    --2--

/*Es importante para la gerencia tener conocimiento del promedio de inscripciones de usuarios mensuales, 
asimismo aquellos meses cuya cantidad de inscripciones supera dicho promedio de manera que pueda promover 
la mayor adquisición de materiales y productos a vender en esos meses*/

    create procedure mesesmayorinscripcion as
    begin
        Declare @promedio NUMERIC(10, 2);

        select @promedio = AVG(total)
        from (
                 select DATEPART(MONTH, DIncripcion) mes, count(1) total
                 from Inscripcion
                 group by DATEPART(MONTH, DIncripcion)
             ) a;

        select @promedio promedio;
        WITH meses AS
                 (
                     SELECT ROW_NUMBER() OVER (ORDER BY value DESC) AS ID,
                            value
                     FROM STRING_SPLIT(
                             'ENERO,FEBRERO,MARZO,ABRIL,MAYO,JUNIO,JULIO,AGOSTO,SETIEMBRE,OCTUBRE,NOVIEMBRE,DICIEMBRE',
                             ',')
                 )
        Select m.value, prom.total
        from (select DATEPART(MONTH, DIncripcion) mes, count(1) total
              from Inscripcion
              group by DATEPART(MONTH, DIncripcion)
              having count(1) > @promedio
             ) prom
                 Join meses m On prom.mes = m.ID

    end

-- ejecución de prueba
        exec mesesmayorinscripcion

        --3--

/*Para la empresa es muy importante reponer el stock cuando este llega a 10 (política de empresa). 
Para ello, se solicita que elabore un trigger, el cual registre en una nueva tabla los datos del producto con stock menor a 10.*/

        create table tb_productobajoenstock
        (
            fecha  datetime,
            motivo varchar(255),
            stock  int
        )
        create trigger tr_productosbajostock
--DONDE SE DISPARA EL EVENTO (TABLA)
            on Producto --tabla donde se dispara el evento
            for Update --CUANDO SE DISPARA EL EVENTO
            as
        begin
            --QUE DEBE HACER

            if UPDATE(stock)
                begin
                    insert into tb_productobajoenstock
                    select GETDATE(), 'Limite de stock del producto: ' + rtrim(ltrim(str(CProducto))), stock
                    from inserted
                    where stock <= 10
                end
        end
            select *
            from Producto
            update producto
            set stock=4
            where CProducto = 115
            select *
            from tb_productobajoenstock


            --4--
            /*Crear un procedimiento para mostrar el dni (cpersona), nombre, apellido y nombre de la sede de todos los empleados que
            contengan en su apellido el valor que le pasemos como parámetro.*/

            CREATE PROCEDURE EMPLEADOLIKEAPELLIDO @APELLIDOPATERNO VARCHAR(30)
            AS

            SELECT p.CPersona,
                   p.NPersona,
                   p.NApellidoPaterno,
                   s.NSede
            FROM Sede s
                     join Empleado e on s.CSede = e.CSede
                     join Persona p on e.CEmpleado = p.CPersona

            WHERE p.NApellidoPaterno LIKE '%' + @APELLIDOPATERNO + '%'

                EXEC EMPLEADOLIKEAPELLIDO 'a'

                --5--
/*La empresa desea saber que cuantas inscripciones ha tenido una determinada sede, En un periodo de tiempo determinado. 
De esto se pide el código y nombre de la sede y la cantidad de inscripciones.*/

                CREATE FUNCTION masinscripcionesdeunasede(@csede INT, @fecha_inicio date, @fecha_final date)

                    RETURNS TABLE
                        AS
                        RETURN
                            (
                                select s.CSede, s.NSede, COUNT(i.CInscripcion) 'cantidad de inscripcion'
                                from Inscripcion i
                                         join PlanSede ps on i.CPlan = ps.CPlan
                                         join Sede s on s.CSede = ps.CSede
                                where s.CSede = @csede
                                  and (i.DIncripcion between @fecha_inicio and @fecha_final)
                                group by s.CSede, s.NSede
                            )

            SELECT *
            FROM masinscripcionesdeunasede(18610, '2016-01-01', '2022-01-01')