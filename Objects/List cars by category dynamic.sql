CREATE OR REPLACE FUNCTION list_cars_by_category_dynamic(p_car_category IN VARCHAR2)
  RETURN ty_car_l IS

  v_sql  VARCHAR2(4000);
  v_cars ty_car_l;

BEGIN

  v_sql := 'select ty_car(vw.category, vw.manufacturer, vw.model, vw.mileage, vw.daily_fee)' ||
           ' from vw_available_cars vw' || ' where 1 = 1';

  IF p_car_category IS NOT NULL
  THEN
    v_sql := v_sql || ' AND UPPER(vw.category) = UPPER(:1)';
  END IF;

  EXECUTE IMMEDIATE v_sql BULK COLLECT
    INTO v_cars
    USING p_car_category;

  RETURN v_cars;

EXCEPTION
  WHEN no_data_found THEN
    pkg_error_log.error_log(p_error_message => 'No data found: Category not found: ' ||
                                               p_car_category,
                            p_error_value   => 'Input category',
                            p_api           => 'list_cars_by_category_dynamic');
  
    RAISE;
    
    when others then
      pkg_error_log.error_log(p_error_message => sqlerrm,
                            p_error_value   => 'Dynamic sql: ' || v_sql,
                            p_api           => 'list_cars_by_category_dynamic');
                            raise;
  
END list_cars_by_category_dynamic;
