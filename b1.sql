CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price) VALUES
(1, 'Laptop Dell', 1, 2000),
(1, 'Chuột Logitech', 2, 50),
(2, 'Bàn phím Keychron', 1, 120),
(2, 'Màn hình LG', 2, 300);

CREATE OR REPLACE PROCEDURE calculate_order_total(
    order_id_input INT,
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COALESCE(SUM(quantity * unit_price), 0)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;
END;
$$;

CALL calculate_order_total(1, NULL);
