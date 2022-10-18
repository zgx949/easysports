import axios from "axios";

export function generateQRcode(stuIds) {
 return  axios.get('https://api.qrserver.com/v1/create-qr-code/',{params:stuIds})
}
