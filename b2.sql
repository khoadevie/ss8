CREATE TABLE inventory (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT
);

INSERT INTO inventory (product_name, quantity) VALUES
('Laptop Dell', 10),
('Chuột Logitech', 3);

CREATE OR REPLACE PROCEDURE check_stock(
    p_id INT,
    p_qty INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_quantity INT;
BEGIN
    SELECT quantity
    INTO v_quantity
    FROM inventory
    WHERE product_id = p_id;

    IF v_quantity IS NULL THEN
        RAISE EXCEPTION 'Sản phẩm không tồn tại';
    END IF;

    IF v_quantity < p_qty THEN
        RAISE EXCEPTION 'Không đủ hàng trong kho';
    END IF;
END;
$$;

CALL check_stock(1, 5);

CALL check_stock(2, 10);
