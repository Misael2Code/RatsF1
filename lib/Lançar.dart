import 'package:f1/Home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sql_conn/sql_conn.dart';

//https://console.firebase.google.com/project/ratsf1-595ba/overview

class Lancar extends StatefulWidget {
  const Lancar({Key? key}) : super(key: key);

  @override
  State<Lancar> createState() => _LancarState();
}

class _LancarState extends State<Lancar> {
  TextEditingController _numRat = TextEditingController();
  TextEditingController _seqRat = TextEditingController();
  TextEditingController _numOpr = TextEditingController();
  TextEditingController _nomCli = TextEditingController();
  TextEditingController _datRat = TextEditingController();
  TextEditingController _horIni = TextEditingController();
  TextEditingController _horInt = TextEditingController();
  TextEditingController _horFim = TextEditingController();
  TextEditingController _km1Cli = TextEditingController();
  TextEditingController _km1Adi = TextEditingController();
  TextEditingController _vlrPed = TextEditingController();
  TextEditingController _codSis = TextEditingController();
  TextEditingController _codMod = TextEditingController();
  TextEditingController _titAti = TextEditingController();
  TextEditingController _obsCon = TextEditingController();

  var maskHour = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  var maskMoney = MaskTextInputFormatter(
      mask: 'R\$ ####,##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blueAccent;
    }
    return Colors.grey;
  }

  clearText() {
    _numRat.clear();
    _seqRat.clear();
    _numOpr.clear();
    _nomCli.clear();
    _datRat.clear();
    _horIni.clear();
    _horInt.clear();
    _horFim.clear();
    _km1Cli.clear();
    _km1Adi.clear();
    _vlrPed.clear();
    _codSis.clear();
    _codMod.clear();
    _titAti.clear();
    _obsCon.clear();
    setState(() {
      ratFat = false;
      cobCli = false;
      fatCon = false;
      homeOffice = false;
      cliente = false;
      f1 = false;
      km1Cli = false;
      somenteIda = false;
      idaVolta = false;
      naoConsiderar = false;
    });
    colorHomeOffice = Colors.black54;
    colorCliente = Colors.black54;
    colorF1 = Colors.black54;
    colorSomenteIda = Colors.black54;
    colorIdaVolta = Colors.black54;
    colorNaoConsiderar = Colors.black54;
  }

  bool ratFat = false;
  bool cobCli = false;
  bool fatCon = false;
  bool homeOffice = false;
  bool cliente = false;
  bool f1 = false;
  bool km1Cli = false;
  bool somenteIda = false;
  bool idaVolta = false;
  bool naoConsiderar = false;
  var colorHomeOffice = Colors.black54;
  var colorCliente = Colors.black54;
  var colorF1 = Colors.black54;
  var colorSomenteIda = Colors.black54;
  var colorIdaVolta = Colors.black54;
  var colorNaoConsiderar = Colors.black54;

  @override
  Widget build(BuildContext context) {
    _numRat.text = "1234";
    _seqRat.text = "1";

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Text(
                      "Novo Relatório Técnico",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 38, bottom: 16),
                        child: Text(
                          "Dados Gerais",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                EdgeInsets.only(top: 4 , right: 4),
                                child: TextField(
                                  controller: _numRat,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Nº Rat:",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(top: 4, left: 4),
                                  child: TextField(
                                    controller: _seqRat,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Sequência:",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9,
                                      ),
                                    ),
                                    onTap: () {
                                    },
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                EdgeInsets.only(top: 4, right: 4),
                                child: TextField(
                                  controller: _numOpr,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.search, size: 16,),
                                    border: OutlineInputBorder(),
                                    labelText: "OP:",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(top: 4, left: 4),
                                  child: TextField(
                                    controller: _nomCli,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.search, size: 16,),
                                      border: OutlineInputBorder(),
                                      labelText: "CLIENTE:",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9,
                                      ),
                                    ),
                                    onTap: () {
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(child: Padding(
                    padding: EdgeInsets.only(top: 38, bottom: 16),
                    child: Text(
                      "Detalhes",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),),
                  Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4, right: 4),
                            child: TextField(
                              controller: _datRat,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(
                                    Icons.calendar_today_rounded,
                                    size: 18,
                                  ),
                                  labelText: "DATA:",
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9,
                                  )),
                              onTap: () async {
                                DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2050),
                                );
                                if (pickeddate != null) {
                                  setState(() {
                                    _datRat.text = DateFormat('dd/MM/yyyy')
                                        .format(pickeddate);
                                  });
                                }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 16, right: 4, bottom: 32),
                                  child: TextField(
                                    keyboardType:
                                    TextInputType.numberWithOptions(
                                        decimal: false),
                                    inputFormatters: [maskHour],
                                    controller: _horIni,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        icon: Icon(
                                          Icons.access_time_rounded,
                                          size: 18,
                                        ),
                                        hintText: "00:00",
                                        labelText: "INÍCIO:",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                        )),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 16, right: 4, bottom: 32),
                                  child: TextField(
                                    keyboardType:
                                    TextInputType.numberWithOptions(
                                        decimal: false),
                                    inputFormatters: [maskHour],
                                    controller: _horInt,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        icon: Icon(
                                          Icons.timer_outlined,
                                          size: 18,
                                        ),
                                        hintText: "00:00",
                                        labelText: "INTERVALO:",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                        )),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 16, right: 4, bottom: 32),
                                  child: TextField(
                                    keyboardType:
                                    TextInputType.numberWithOptions(
                                        decimal: false),
                                    inputFormatters: [maskHour],
                                    controller: _horFim,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        icon: Icon(
                                          Icons.access_time_rounded,
                                          size: 18,
                                        ),
                                        hintText: "00:00",
                                        labelText: "FIM:",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(238, 243, 249, 1),
                                borderRadius: BorderRadius.circular(16)),
                            padding: EdgeInsets.only(
                                top: 16, bottom: 8, right: 8, left: 8),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.only(top: 4, bottom: 26),
                                  child: Text(
                                    "Local do Serviço",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black54),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Cliente",
                                          style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: colorCliente),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                              "Home Office",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                  color: colorHomeOffice),
                                            ))),
                                    Expanded(
                                        child: Center(
                                          child: Text(
                                            "F1",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                                color: colorF1),
                                          ),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Switch(
                                        value: cliente,
                                        activeColor: Colors.blueAccent,
                                        onChanged: (bool value) {
                                          setState(() {
                                            cliente = value;
                                            if (value == true) {
                                              colorCliente =
                                                  Colors.blueAccent;
                                              homeOffice = false;
                                              colorHomeOffice =
                                                  Colors.black54;
                                              f1 = false;
                                              colorF1 = Colors.black54;
                                              km1Cli = true;
                                            } else {
                                              colorCliente = Colors.black54;
                                              km1Cli = false;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Switch(
                                        value: homeOffice,
                                        activeColor: Colors.blueAccent,
                                        onChanged: (bool value) {
                                          setState(() {
                                            homeOffice = value;
                                            if (value == true) {
                                              colorHomeOffice =
                                                  Colors.blueAccent;
                                              cliente = false;
                                              colorCliente = Colors.black54;
                                              f1 = false;
                                              colorF1 = Colors.black54;
                                              km1Cli = false;
                                            } else {
                                              colorHomeOffice =
                                                  Colors.black54;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Switch(
                                        value: f1,
                                        activeColor: Colors.blueAccent,
                                        onChanged: (bool value) {
                                          setState(() {
                                            f1 = value;
                                            if (value == true) {
                                              colorF1 = Colors.blueAccent;
                                              cliente = false;
                                              colorCliente = Colors.black54;
                                              homeOffice = false;
                                              colorHomeOffice =
                                                  Colors.black54;
                                              km1Cli = false;
                                            } else {
                                              colorF1 = Colors.black54;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: _km1Cli,
                                            enabled: km1Cli,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.map_outlined),
                                              labelText: "KM CLIENTE:",
                                              labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 9,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        )),
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: _km1Adi,
                                            enabled: km1Cli,
                                            decoration: InputDecoration(
                                              icon:
                                              Icon(Icons.fmd_good_outlined),
                                              labelText: "KM ADICIONAL:",
                                              labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 9,
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ))
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 7.5,
                                                offset: Offset(0.0, 0.75))
                                          ],
                                          color: Color.fromRGBO(
                                              238, 243, 249, 1),
                                          borderRadius:
                                          BorderRadius.circular(16)),
                                      padding: EdgeInsets.only(
                                          bottom: 8, right: 8, left: 8),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Text(
                                              "Considerar KM Cliente",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Switch(
                                                  value: somenteIda,
                                                  activeColor:
                                                  Colors.blueAccent,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      somenteIda = value;
                                                      if (value == true) {
                                                        colorSomenteIda =
                                                            Colors
                                                                .blueAccent;
                                                        idaVolta = false;
                                                        colorIdaVolta =
                                                            Colors.black54;
                                                        naoConsiderar =
                                                        false;
                                                        colorNaoConsiderar =
                                                            Colors.black54;
                                                      } else {
                                                        colorSomenteIda =
                                                            Colors.black54;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Switch(
                                                  value: idaVolta,
                                                  activeColor:
                                                  Colors.blueAccent,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      idaVolta = value;
                                                      if (value == true) {
                                                        colorIdaVolta =
                                                            Colors
                                                                .blueAccent;
                                                        somenteIda = false;
                                                        colorSomenteIda =
                                                            Colors.black54;
                                                        naoConsiderar =
                                                        false;
                                                        colorNaoConsiderar =
                                                            Colors.black54;
                                                      } else {
                                                        colorIdaVolta =
                                                            Colors.black54;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Switch(
                                                  value: naoConsiderar,
                                                  activeColor:
                                                  Colors.blueAccent,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      naoConsiderar = value;
                                                      if (value == true) {
                                                        colorNaoConsiderar =
                                                            Colors
                                                                .blueAccent;
                                                        somenteIda = false;
                                                        colorSomenteIda =
                                                            Colors.black54;
                                                        idaVolta = false;
                                                        colorIdaVolta =
                                                            Colors.black54;
                                                      } else {
                                                        colorNaoConsiderar =
                                                            Colors.black54;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "Somente Ida",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color:
                                                        colorSomenteIda),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Center(
                                                      child: Text(
                                                        "Ida e Volta",
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color: colorIdaVolta),
                                                      ))),
                                              Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      "Não Considerar",
                                                      style: TextStyle(
                                                          fontSize: 9,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          colorNaoConsiderar),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 24,
                                                bottom: 16,
                                                right: 16,
                                                left: 16),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text(
                                                        "KM Percorrido: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .normal,
                                                            color: Colors
                                                                .black54,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "1234",
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .black87,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 16),
                                                  child: TextField(
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                        decimal: false),
                                                    inputFormatters: [
                                                      maskMoney
                                                    ],
                                                    controller: _vlrPed,
                                                    decoration:
                                                    InputDecoration(
                                                        icon: Icon(
                                                          Icons
                                                              .monetization_on_rounded,
                                                          size: 18,
                                                        ),
                                                        hintText:
                                                        "R\$ 0,00",
                                                        labelText:
                                                        "PEDÁGIO:",
                                                        labelStyle:
                                                        TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize: 9,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16, right: 32, left: 32),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rat Faturada (NF + Boleto)",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor:
                                  MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: ratFat,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      ratFat = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 32, left: 32),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Cobra do Cliente",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor:
                                  MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: cobCli,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      cobCli = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 32, left: 32),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Agenda Faturada (Consultor)",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor:
                                  MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: fatCon,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      fatCon = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Center(child: Padding(
                    padding: EdgeInsets.only(top: 32, bottom: 16),
                    child: Text(
                      "Relatório de Atendimento",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),),
                  Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                EdgeInsets.only(left: 4, right: 4),
                                child: TextField(
                                  controller: _codSis,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.search, size: 16,),
                                    border: OutlineInputBorder(),
                                    labelText: "SISTEMA:",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(right: 4, left: 4),
                                  child: TextField(
                                    controller: _codMod,
                                    enabled: true,
                                    decoration: InputDecoration(

                                      suffixIcon: Icon(Icons.search, size: 16,),
                                      border: OutlineInputBorder(),
                                      labelText: "MÓDULO:",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ))
                          ],
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(top: 8, right: 4, left: 4),
                          child: TextField(
                            controller: _titAti,
                            enabled: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "ATIVIDADE (ASSUNTO):",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(top: 12, right: 4, left: 4),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _obsCon,
                            enabled: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "DESCRIÇÃO:",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Padding(
                        padding: EdgeInsets.only(top: 42, left: 26, right: 26, bottom: 18),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey),
                            onPressed: () {

                            },
                            child: Text("Duplicar")),
                      ),),
                      Expanded(child: Padding(
                        padding: EdgeInsets.only(top: 42, left: 26, right: 26, bottom: 18),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent),
                            onPressed: () {

                            },
                            child: Text("Salvar")),
                      ),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(26),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        onPressed: () {
                          clearText();
                        },
                        child: Text("Limpar")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
