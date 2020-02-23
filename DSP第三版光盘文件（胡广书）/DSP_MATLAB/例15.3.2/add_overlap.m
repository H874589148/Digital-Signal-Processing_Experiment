function y=add_overlap(f,win,inc)
    [m,n] = size(f);
    w = win';
    n_buf = ceil(n/inc);
    buf_len = n + (m-1)*inc;
    y_tmp = zeros(buf_len,n_buf);
    y_tmp(repmat(1:n,m,1)+repmat((0:m-1)'*inc+rem((0:m-1)',n_buf)*buf_len,1,n)) = f.*repmat(w,m,1);
    y = sum(y_tmp,2);
end
