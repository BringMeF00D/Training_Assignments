create table orders(order_id varchar2(20) constraint pk_order_id primary key ,cart_id varchar2(20) not null, customer_id varchar2(20) not null, order_date date DEFAULT sysdate, delivery_date date default sysdate + 7, coupon_id varchar2(20) not null, bill_amount number(12,2), payment_method varchar2(2),
                  constraint fk_cart_to_order foreign key (cart_id) references carts(cart_id), constraint fk_cust_to_order foreign key (customer_id) references customers(customer_id), constraint fk_coupon_order foreign key (coupon_id) references coupons(coupon_id), constraint ck_pay_meth check(payment_method in ('COD', 'CREDIT', 'DEBIT', 'E-WALLET'))
);

CREATE SEQUENCE orders_id_seq;

CREATE OR REPLACE TRIGGER order_tgr
    BEFORE INSERT
    ON orders
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.order_id IS NULL THEN
        SELECT 'O'||TO_CHAR(orders_id_seq.NEXTVAL,'0000000') INTO :NEW.order_id FROM DUAL;
    END IF;
END;