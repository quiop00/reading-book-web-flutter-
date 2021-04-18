import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width*0.8 / 2;
    return Container(
      //height: MediaQuery.of(context).size.height*0.8,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          children: [
             BookListElement(),
             BookListElement(),
             BookListElement(),
             BookListElement(),
             BookListElement(),
              ],
         ),
    );
  }
}
class BookListElement extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width*0.7 / 2;
    return Container(
      height: 100,
      width: 200,
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: itemWidth*0.28,
              height: itemHeight*0.65,
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBYWFRgWFRYYGBgYGBgYGBgZGhgYGBgaGBoZGhgYGhgcIS4lHB4rHxgYJjgmKy8xNTU1GiQ7QDszPy40NTEBDAwMEA8QGhISGjQhISE0NDQ0NDQ0NDE0NDQ0NDQ0NDE0NDQ0NTQ0NDQxNDQ0NDQ0NDE0NDQ0NDQ0NDQ0PzQ/Mf/AABEIAKkBKgMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAACAwEEBQAGB//EADgQAAICAAUCBAMGBgICAwAAAAECABEDBBIhMUFRBSJhcYGRoQYTMkKx8BRSgsHR4WJyI/EHM6L/xAAYAQEBAQEBAAAAAAAAAAAAAAAAAQIDBP/EAB4RAQEBAQEAAgMBAAAAAAAAAAABEQIhEjEDQWFR/9oADAMBAAIRAxEAPwD5IFhhYQElRNIELCCw0WHUoUFhhYVQgpr4wBCwgIWkSQsMhuSDCqRUDpBkiTpgSJInLxD07X1gLnSTCVbgCq3CqEq7xWO+gWd/SBWbNENW1XvsbqXQspYmbQrp09QQaFjYg73Zv9+lnKYgaqY7cg1+skWm6ZxSO0Qis1jOq2mQUllkEBl2EYKrLI+7lh0kMJF0KpC0xgEMpLgrlIp1lwpFskYKemcVjXXeCwgABOIhATqgJYRTrLJSA4ksaUyJEeyfv3g1IDCw0WGqwwsYmhUQiNzCCwqlQsrLDtaqCF8ooUACevmrnnn2gFYarABUhqscmEaj8LDvpzLhqouHBCTQGCBzdVEOkCrpkVH6YBWQCV2kMaF1ff0+UZRqTQr1hdKVgxNd+P30h1vKzJoaxwf3Uvot0R1iJXYaaiAOu28z84+tyVFDYADoFFD6frNJUN7bGL8MCAjWQpPc16SdU5mshco54U/KGMFkIsV2vbee7y6JQJK132/WUfHcqroClMdQFrXJ2AviYnTp8XnMPOFSUdTakg9wQaIr3l5MZW6yM3k9TFj+Im2PNk8zPxMJkM6/Tl41WAI2gMu3EopmO447bSymOSBv8+kumJdILKeseov97Q2QRiEKIcllnAQqDFNGOYtxAURFuN44iLYSKCp1QpOmUAEu+T19h3gMkfUnTIKbpF6JddYnRJjSFENRBEYsMiWERIUbxicV3IPS9r69tz9IEBZYw8OcuHLCYW374mpDR5PL2T2lz7sAbD4wMvdHePRZrGKSU52lJ12M2FwiQSPj9ZUdKuSwlZn3cBRR3FixY4v0vpLTDn2ixhTLRJHp3ENcLaWUwbllcDaBnNl7FHtt6SvgAr3oHce3btNZkqZ+ZBs7bXuasC/97TNWf4ZhmzLmF4Ojka+CCy9Qws7/ADBEp+G4Bd9KBnLbDSCQP8dPmJrZ3VhYeGCQQzOVI/IeChPU7AkdCY6lvOrz1OesO8N8JwnwSjjh2qjv0of6jcxk0w0pVpQQSe5XdRt1sCI8C1jUwRQWvz6Cb/8A1O8czLMyYSMBSYmI451lV1KvuVV69SO858za31bIoLuKvrcFsAMISsCoI4PBjcOeqTXmZuJ4b1EBcrp5G3UTaqc6Xz0i8xflWZg4dHTyDx/eOfCI6RqrpNev+v7w8Q3zGGqbLxBcSw4uC2H2ma0psIt5ZdbMQV3kUsrFssewiyIICcD/AHnMJ0LhjaNC1q12dV6dBG2nT1B5u76e0AGQJDNA5oGmcTJkCFMYpi1EYszFpgjEEWI1JqIfgrZl3BQ/KUsNqM0cu4A378+k1EpwUDbn6Sxh8RDAcg2LIBoiwOu/6Qkmoyv4Nnjrz/7+MpZld6HTj9iOXF/fHM4KDv6D5xSKa5f67H9IX8Ke008vhNa0CeD9DxOxMFhZYrfWtQv5zOF699VFwwBVQWSL/iWLEINVciiDXpfMLJ5pmY6lUbb6iVr6TKlsoB3nYeIG4XVsaXSX191KrvXc7dZeXw131OUcYC2zubRWA3K4djdmOwq6uzxM3H8SLEaEGCovSibciiWf8TtRIsmXf4Yfm8wXS1rCKkBEVdCivyBAKFcx3geCmPgHBxPwuz6e6Nt5h6ggTGVtHmLVZ26mzya4nofCcNLY3qfv6HsBxv8A2k+Vkz9GS+/t53Lu+WxXwsZ3BQ7AEhXHII9xHeA5ZsxjHEb8rXY/mPIHoAAP6hPS+P8AhAzKBlAGMgOk8a1/lP8AY9D6EyfAMn91g0RTb3f8x/F8uP6ZOZJ61bbHk89eDiunAslb4Kk7H+3wlrDe6JFEk+23X9Ze+2eDeCrgbhxv10aWB399M8tk84dtR/C17nkGhV+lcTpzXOyvTaanTNwMekXvQsE11I3Pfb6y/g4yuLXjt2nTUJdfP9YbCNr59Y5MEHf3qvQXvcYW4pKkjHNCusu/d17ynjrzMWLFFxI017niNC94jEb1quP9fvpMtFPzvI6cdef3+9pxEnpI0UwgaZc10rJpQltJ1csKF0rXS877Xtz0itMGlBJDJH1IIg1X0SdMdU6oNZ6xixaxgmWjBGKZCBdJstq20igVI62bsH4GcssZPUxyNKwMs5Zq6c/6/wASlXMO5aXD6joPS/gJVUxgZqvauORffi7qalc7KtJijgjb0O808sqccG63YA+vImBhudQoy+uJfX3J+Y6bdJdLzf09ImbXDYFGDHji9gO3eaWVRMagy7nbgAbf4nj8vmlQhm3o9bNdLocT0H2e8S1493soJ22FE8bi+f0mb0TnPt7DK+AYKU2hb9QD87Ewsx9pcsnnCIzflIRLA/KBtttNnxTxlEwMVtVacPEI72FNfWp8WGa6IKHFnc/Lpz1nKS9O3kem+0X2qfHUo3kQm9zua/WeZ2bcOle4mZjZlmcBmLAEiix2vZiN9jx8hO0jYLvZAPYfGb55Y76WnwtZCg6idgqhmJ+U9J4J4a6JrLJ5aGk6r08H0v8AxKHheHoQsAS7eRTXA6sCPcbntPceH5SkAWyy+Vr3+O+w5M6XmSevPOr1fEYATbzDcbEAkG+l9jCx8uopQ4IAFkfr/eBlfCzhmncVYKpWp24qmNAb73vxDzrhQaHpvub95LPPpZNvlYH2iw9aaB6gV0A3Jng8DD0uVbgEXXSus+mLpP4uaIHY3+xPDeN5TS4K7k7Gu/Q17SR0nXuK2INhfA1V/mMyWMUGu6XgA/mvv/npEOmhF1eY/wAu9exIguHegaHU1wBzQ9Jf2r0mRp1DdDuAe3FmX8unm24G5+EzPCQ2nSBQG1+3Sb+BlqTnckXYPHX47zrz7HLrqTxTOEDf14mVmUtpt5hQB6/SZ2YwCqB9qJIG4skc+W7r146czPTXLJxiOJUeWcQ7muYnEQDgg7DcX1ANbgccfCc66wljBBjF2/fPp9IEiiUTjOWSRCOqDCMgygZ1yTIqBnKYawVEICYapoMgvIWC3O31lQ5HlrBeZoeWcHElGp97JD9pS1RgeEw/XZviXstj1sAPjv8AQzKVpZyxs1fy52lF3MrtvtYsfGT4bn2wm8vUVtzYO20PMYYZRRrapHh+TGsGztGDRxi7oysW1ONIBHQkE324Ejwv7Ns7AKLqvYnjcmbeWQdxPUeDIicEE8ky4zr5J4p9k8XCdlItuqg8A8W31lTL+HKm7ku22lVvQLP5m6/CfTf/AJTxlXLK62GZ0TUO1E+Ydeu3+J4jD8OQoztiEPgsA6AAB+NJw23Jv+Yim6VHP9c/yW/TSyoYnDDNsoOpQAqrwB5fiN56nLuiKQfzD3O3UieY8CyjYurEGwtQqk2RRU2SedprZlWRgzEEc7H6R3bsrP4pMsaLYjKCX/EQQGC+dQezdPnMQZhsR9AUk9BuSw3o77n6+828pnFcaCpYfm6KB0tufgJV8VzIw11YXl0fiUbE368n39InrU6y5nqtieEsN8Vlwx6kavl+/aeT+1Waw0GjB7i36tv3O9S/4ljvi6X1Ehhf7+U8n42Trr2k1vPfVpMlrwQ46WPluZTwW07AksT70NunU8T3WSw7yiaVBY4aHtuVHM80ng7O9V5jtXSdLznqbpuTxnC+UDYg1z33P/L0ua6ZpgoI1MxoANQBPpsdprYnhuDlsJQ5LPXQbDYclRQ+Jnl85mvOSuodBW224I9B0+MTrz1mc+/S2+Le5YE9hfy+kqeIIUNHYigwNWCRuPUesBPN6c/QdPWBipv39ZL63JiqF5uA6dJZOEYDYdTONqjLFaZadYOmTFJAhVJqcYQBgyXgiQTIkmRcq4zxDEAQwZgSIGJCuC0oVcbhPFmDco0w1iEplHL43SXQ4EFKzONp2B3MrJikdaiMbEtiYOqTRqZfHP8AMRNjJeJiwGNH+bofeeUXEMccexLpj6Dl8+t1c3sl4hxRufJ8DPsook109Jq5HxkoQCbEus4+jfaUfxOWfDq22dP+y7jf1Fr/AFT5Zkc/jIulMRlQnddXl3PY7fKe3y3jCFBR533P7uYL55Qz4VIFZXYNSgo9qw8/IBGoV6jbaVmzyvafZ7MI+CuGCwZV3dt1e+ljjnt0mZ49lsTCYFQH9TuPpPIeG+MYuF5UxCou6O4vboQRPdeH/bFWUK6K52GyXfuorr6ROpfK49fj75vy5D4J46FwMTDxKV2Y6aRjfAA3PcH5yXdnQgcsAoIGzEsCCBfQA/McS74h4xkkN4mEEa71CqJ6EU4Myc99tFK6cBFUGxrPNbWQKofWb5vMcr871LgMx91lQS7ambcLXf8AMBZoHmeUzql3BWiztQUb1QNe8jxXNYjMSyGz+I69Zv8A5AXXsZZ8EAR1fECpp/Dq7HkgfzHeYvUvX8ermWTb917jJYCoiIN9CKo/pAEN1GG+q1U1dfnYmwBfQe1SlieNIq/+Ecj8Z5+HaUlY2cTEPA2vn9mb76yLxxb0DxvxCxpJOna6q66gTJTEDb1ZJskmz8e5is8/3j7Ch0HPzMdlsLSKM487a6dZ9QSYcNwJJaATO7GFvFaY9liMV6koViVFVD5klZholhBjWWAVjAphBIjqgMkmBJMC41li9MKorGVEoYbNMDiZBMiTUAGiiY4pAZYaAGqWFxLErESUaoTAEwS0PENxcKkNC1QQIQEAjBDGTIlZnizg+IMgofD0iA12WJs9/WLZTt6xmKlbXfr+sFSnxPtcs4bsPw6x30lhK2E1TS8KwWxMRMNN2dwqi9ySeJixr5KpS+dZ/wC2szZw/BQ2Gjo6EPYew4+7YXQcgE0a2IFb/Geh8Z8O/hWxzl8Y4yYWIi4oSjiYKMLAd6ZeToJ7jjY1jeM+IMrhUzWvDZFdWQIjU10mIFHlcVuPYjYiNZstIfKvhFvvdCEKdLBg7ufy6aN16kCUHzYb8dv2JPmHs3I9uJUY2SxYEnkkkk+8LD0Ejzcmr5hrG34d4ouGtUWri+f0oS4+bfGonyr+/nMHHw/u6ZfML3JHHrVy7hZrUOZqTb6m+eNFCF4+ck4soffes44k6azi6caGp2ux7dZnjEnHFl+SYvfer3ETiSkGjVMaYMmdriy0HVIGkwSYBacDCjkESRIMACIH3cbIuBgBoxWiqkic2zyIQigYxTDKGgGMYRREBZW5OmPRJzJC6rMsHTHMIKrCoCTtFR4WEcImVlVqdUeuAxNVxzBCbyhRSHgp3kuscidB++8eCVTae88ETCySoy6cxnsdNSIrhMPLYbKXLPiGtLlLJoggXRX8R8I78CWvCc8uDiq7IjgaxockK2tGTzVuR5rrrLZ4xL691ncvmsv4fi4xx8ADMBB91haNARn0lVCjS2rUwZtztWo7mfN8dNJ9CLB7g8fHYj4GbPiuexsRcLDbSuFpDYWFhf8A1ganS6ssW1K48xJHmlHHybppTEUozqHw7rcNdfBqIHqB6zMjVZjidVb/ABhONoa8fCZ6jcWMPHsUeOo/WLRip526e0rbiMD3zLBd/iIaZi5RB6RiOeJdZXmxQBdiVMXOX+GVsYmyD0M5EuNDUzL9/oJcws09b18IvBw17fWWHwxUqWmJjAySblIc7R6PU1oaIxTK4eMQwHrOIgapIeEC0GzDaBCsQCcROWFObYQY5WiSZCvGiyGnRIeMV9qob73W49j++faqyOoJkhpxgMTBBFyGwajss9jTQ2PIG/Xk/H6CPxcGMTVNaveWHw7O0W+FLGUNsAQOANhXAqz6wunrky29dJcyH2Sxcc/+LSTqUG200D135+EuZZaFT0H2bfS92RZr/cuJrw/2g+zr5XFGG7BiVDWONybG/tMbGO5E9h9v80TmPMbIRf7zxLvuZFTe83fs3ncyHVMCnFlmRkR0ZfzF1bkb9x6ETAwcSiDQNb0RYPuOsfhYhBsBf6kRxv8A8XBH0lHv1TxNMsUKKuAjNoITK6vOxYph+ZjVsdgLA29J5v7Q+HHDXCd2f7zEDs+HiUXQKQFax+Vt6HTTFZbx/M4alcPHfDVuVQ6F45CrQB25FGZpx21F287Hcl/OSe5J5PqYkKPM5YnDXG5VmZGPZ1Aaj/2UhvWm7Sig5+csJnWUYiDToxdOta2BRtSMv8rC2APZ2HWV15mb6sEwiyJZQ6TdA+hFiJZZIqE6XuBHfejoK/ffmKAjsMVeymxW4sj1HYysucgm6h4awFT1hiUpwYCc2JEnF2KgDfrW/Tr/AE/U94JFRDDAYYaKQxwbYCht1rc88n4/QdpQStCDRYnapUWFaGpiFeNDygy0ipCmHqgYiyZCyZzbA4gGG0GSiA1Qw8S0JJYLKtCUxUNJWVvAXzAi5uthbD2mTlJur0mox07JeFfebVR6f79PWUM7kHwXKuCOo/yDPWZD8ae4ivtt+DD/AK/1E6fGfF5L+bqfmnH6YuVxgw9RNPI5nSwPrPPeGfimss5vZPp5z7R5ovjuSb4HyEycLGK3QBvamAI5B6+31j8/+N/+x/WVJluDwsSjdWTd3xuCD+sejkNq2vc8bb+kqYfMtrEQbP5r271W3ykq51aqHN1W13fHb0izzGLKAvz6qGxBqttvT4SHNm/b6CocCATiDVxjRSyCSkgRrxSwRwhFpGHwfjAgcXhK8Q3MYkgdcnVIE6UNUxbNObiLPEoNcSWEMpCXcPiSFOUw4tYybR//2Q=="),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Center(
                      child: Text("Cậu bé đeo tất xanh", style: TextStyle(fontSize: 30),),
                    )
                  ),
                  Flexible(child:
                    Text('Tại trong tan hoang quật khởi, tại trong tịch diệt khôi phục. Biển cả thành bụi, lôi điện khô kiệt, sợi u vụ kia lại một lần tới gần đại địa, thế gian gông xiềng được mở ra, một cái thế giới hoàn toàn mới như vậy để lộ một góc thần bí ',
                      maxLines: 4,overflow: TextOverflow.ellipsis,)
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.account_circle,color: Colors.grey,size: 12,),
                              SizedBox(width: 5,),
                              Text('Nguyễn Văn An'),
                            ],
                          )),
                          Container(
                            width: itemWidth*0.1,
                            height: 25,
                            padding: EdgeInsets.only(right: 5,bottom: 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ElevatedButton(
                              onPressed:(){},
                              child: Center(child: Text('Đọc')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}