// 去掉空格
function trim(value) {
  if (value)
    value = value.replace(/^\s*|\s*$/g, "");
  if (!value)
    return "";
  else
    return value;
}


// 对参数编码
function encodeStr(val) {
	return encodeURIComponent(encodeURIComponent(trim(val)));
}


