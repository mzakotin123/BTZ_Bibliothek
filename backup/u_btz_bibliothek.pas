unit U_BTZ_Bibliothek;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, DBCtrls;

type

  { Tfrm_BTZ_Bibliothek }

  Tfrm_BTZ_Bibliothek = class(TForm)
    bt_erster_DS: TButton;
    bt_vorheriger_DS: TButton;
    bt_naechster_DS: TButton;
    bt_letzter_DS: TButton;
    bt_neu: TButton;
    bt_speichern: TButton;
    bt_loeschen: TButton;
    bt_Titelbild: TButton;
    CB_Ausbildungsgruppe: TComboBox;
    CB_Ausbildungsraum: TComboBox;
    CB_Berufsbezeichnung: TComboBox;
    CB_Nachname: TComboBox;
    CB_Titel: TComboBox;
    CB_Kurztitel: TComboBox;
    CB_Verlag: TComboBox;
    CB_Auflage: TComboBox;
    CB_Erscheinungsjahr: TComboBox;
    CB_Seitenzahl: TComboBox;
    CB_Fachrichtung: TComboBox;
    CB_Kurzbezeichnung: TComboBox;
    CB_EAN: TComboBox;
    CB_Vorname: TComboBox;
    Img_Titelbild: TImage;
    L_Erklaerung_Listenfeld: TLabel;
    L_Fachrichtung: TLabel;
    L_Seitenzahl: TLabel;
    L_EAN: TLabel;
    L_Autordaten: TLabel;
    L_Titel: TLabel;
    L_geschwKlammer: TLabel;
    L_Berufsdaten: TLabel;
    L_ReadOnly_BuchID: TLabel;
    L_KeyPress_Erscheinungsjahr: TLabel;
    L_KeyPress_EAN: TLabel;
    L_Ausbildungsgruppe: TLabel;
    L_Ausbildungsraum: TLabel;
    L_Berufsbezeichnung: TLabel;
    L_Buecherliste: TLabel;
    List_Buecher: TListBox;
    L_Kurzbezeichnung: TLabel;
    L_Kurztitel: TLabel;
    L_Verlag: TLabel;
    L_Auflage: TLabel;
    L_Erscheinungsjahr: TLabel;
    L_Titelbild: TLabel;
    LE_BuchID: TLabeledEdit;
    L_Vorname: TLabel;
    L_Nachname: TLabel;
    OD_Titelbild: TOpenDialog;
    SD_Daten: TSaveDialog;
    TabControl_Autor_Beruf: TTabControl;
    procedure bt_erster_DSClick(Sender: TObject);
    procedure bt_naechster_DSClick(Sender: TObject);
    procedure bt_TitelbildClick(Sender: TObject);
    procedure bt_letzter_DSClick(Sender: TObject);
    procedure bt_loeschenClick(Sender: TObject);
    procedure bt_neuClick(Sender: TObject);
    procedure bt_speichernClick(Sender: TObject);
    procedure bt_vorheriger_DSClick(Sender: TObject);
    procedure CB_AuflageKeyPress(Sender: TObject; var Key: char);
    procedure CB_BerufsbezeichnungChange(Sender: TObject);
    procedure CB_EANKeyPress(Sender: TObject; var Key: char);
    procedure CB_ErscheinungsjahrKeyPress(Sender: TObject; var Key: char);
    procedure CB_FachrichtungChange(Sender: TObject);
    procedure CB_SeitenzahlKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure List_BuecherClick(Sender: TObject);
    procedure TabControl_Autor_BerufChange(Sender: TObject);
    procedure ComboBoxesBerufClear();
  private

  public

  end;

var
  frm_BTZ_Bibliothek: Tfrm_BTZ_Bibliothek;

implementation

{$R *.lfm}

{ Tfrm_BTZ_Bibliothek }

//Prozedur zum Erzeugen des Formulars(Parameter Sender als Objekt)
procedure Tfrm_BTZ_Bibliothek.FormCreate(Sender: TObject);
begin
 top:=10;
 left:=10;

 TabControl_Autor_Beruf.TabIndex:=0; //Tab 1 (Autor) wird ausgewählt.
 CB_Berufsbezeichnung.ItemIndex:=-1; //Es ist anfangs kein Beruf ausgewählt.

 {Alle Labels  sowie Auswahlfelder zu den Autordaten werden eingeblendet/
  sind sichtbar}
   L_Vorname.Show;
   CB_Vorname.Show;
   L_Nachname.Show;
   CB_Nachname.Show;
   L_Autordaten.Show;

 {Alle Labels (Bezeichnungsfelder) und ComboBoxen (Kombinations- bzw. Auswahl-
  felder) bezüglich des Berufs werden ausgeblendet/unsichtbar}
   L_Berufsbezeichnung.Hide;
   CB_Berufsbezeichnung.Hide;
   L_Fachrichtung.Hide;
   CB_Fachrichtung.Hide;
   L_Kurzbezeichnung.Hide;
   CB_Kurzbezeichnung.Hide;
   L_Ausbildungsraum.Hide;
   CB_Ausbildungsraum.Hide;
   L_Ausbildungsgruppe.Hide;
   CB_Ausbildungsgruppe.Hide;
   L_Berufsdaten.Hide;

  {Die ID eines neuen Buches ist stets die nächste Zahl nach der Anzahl der
   bereits im Listenfeld eingetragener Bücher}
   LE_BuchID.Text:=IntToStr((List_Buecher.Items.Count)+1);
end;

procedure Tfrm_BTZ_Bibliothek.List_BuecherClick(Sender: TObject);
begin
// wenn Datensatz mit Index von 0 bis 9 (Nummer 1 bis 10) ausgewählt
  if(List_Buecher.ItemIndex >=0) then
   begin
    CB_EAN.ItemIndex:=List_Buecher.ItemIndex;
    CB_Titel.ItemIndex:=List_Buecher.ItemIndex;
    CB_Kurztitel.ItemIndex:=List_Buecher.ItemIndex;
    CB_Verlag.ItemIndex:=List_Buecher.ItemIndex;
    CB_Auflage.ItemIndex:=List_Buecher.ItemIndex;
    CB_Erscheinungsjahr.ItemIndex:=List_Buecher.ItemIndex;
    CB_Seitenzahl.ItemIndex:=List_Buecher.ItemIndex;
    CB_Vorname.ItemIndex:=List_Buecher.ItemIndex;
    CB_Nachname.ItemIndex:=List_Buecher.ItemIndex;

 // BuchID wird um 1 erhöht
    LE_BuchID.Text:=IntToStr(List_Buecher.ItemIndex+1);
   end
  else //wenn kein Datensatz ausgewählt
   showMessage('kein Wert aus der Liste ausgewählt');
end;

//Prozedur beim Übergang zum anderen Tab durch einen Klick (Autor <-> Beruf)
procedure Tfrm_BTZ_Bibliothek.TabControl_Autor_BerufChange(Sender: TObject);
begin
  if (TabControl_Autor_Beruf.TabIndex=1) then //wenn Tab 2 (Beruf) ausgewählt
   begin
  {Alle Labels  sowie Auswahlfelder zu den Autordaten werden eingeblendet/
   sind sichtbar}
    L_Vorname.Hide;
    CB_Vorname.Hide;
    L_Nachname.Hide;
    CB_Nachname.Hide;
    L_Autordaten.Hide;

   {Alle Labels (Bezeichnungsfelder) und ComboBoxen (Kombinations- bzw. Auswahl-
    felder) bezüglich des Berufs werden eingeblendet/sichtbar}
     L_Berufsbezeichnung.Show;
     CB_Berufsbezeichnung.Show;
     L_Fachrichtung.Show;
     CB_Fachrichtung.Show;
     L_Kurzbezeichnung.Show;
     CB_Kurzbezeichnung.Show;
     L_Ausbildungsraum.Show;
     CB_Ausbildungsraum.Show;
     L_Ausbildungsgruppe.Show;
     CB_Ausbildungsgruppe.Show;
     L_Berufsdaten.Show;
   end
   else
   //gleiches Ereignis, wei beim Erzeugen (Laden) des Formulars
    frm_BTZ_Bibliothek.FormCreate(Sender);
end;

//selbstgeschriebene Prozedur
procedure Tfrm_BTZ_Bibliothek.ComboBoxesBerufClear;
begin // Leeren aller Berufskombinationsfelder außer Berufsbezeichnung
 CB_Fachrichtung.Clear;
 CB_Kurzbezeichnung.Clear;
 CB_Ausbildungsraum.Clear;
 CB_Ausbildungsgruppe.Clear;
end;

procedure Tfrm_BTZ_Bibliothek.CB_BerufsbezeichnungChange(Sender: TObject);
begin // Füllen von Kombinationsfelder im Tab "Beruf"
if (CB_Berufsbezeichnung.ItemIndex=0) then //wenn Fachinformatiker ausgewählt

  begin // Leeren aller Berufskombinationsfelder außer Berufsbezeichnung
    frm_BTZ_Bibliothek.ComboBoxesBerufClear;
    CB_Fachrichtung.Items.Add('Anwendungsentwicklung');
    CB_Fachrichtung.Items.Add('Systemintegration');

    CB_Ausbildungsraum.Items.Add('4004');
    CB_Ausbildungsgruppe.Items.Add('IngE-IT/MG');
  end
  else if (CB_Berufsbezeichnung.ItemIndex=1) then
  //wenn Mediengestalter ausgewählt

   begin // Leeren aller Berufskombinationsfelder außer Berufsbezeichnung
    frm_BTZ_Bibliothek.ComboBoxesBerufClear;
    CB_Fachrichtung.Items.Add('Digital und Print');
    CB_Kurzbezeichnung.Items.Add('MG');

    CB_Ausbildungsraum.Items.Add('4004');
    CB_Ausbildungsgruppe.Items.Add('IngE-IT/MG');
   end
   else if (CB_Berufsbezeichnung.ItemIndex=2) then
   //wenn Kaufleute ausgewählt

    begin // Leeren aller Berufskombinationsfelder außer Berufsbezeichnung
     frm_BTZ_Bibliothek.ComboBoxesBerufClear;
     CB_Fachrichtung.Items.Add('Industrie');
     CB_Fachrichtung.Items.Add('Büromanagement');
     CB_Fachrichtung.Items.Add('Einzelhandel');
     CB_Fachrichtung.Items.Add('Verkauf_KL'); //KL=Kaufleute

     CB_Ausbildungsraum.Items.Add('BOB');
   //BOB=alle Räume im BTZ-Erdgeschoss außer 4004 (IngE-IT/MG) und
   //Toilettenräume

     CB_Ausbildungsgruppe.Items.Add('IngE-KL');
    end
    else if (CB_Berufsbezeichnung.ItemIndex=3) then
    //wenn Fachpraktiker ausgewählt

     begin // Leeren aller Berufskombinationsfelder außer Berufsbezeichnung
      frm_BTZ_Bibliothek.ComboBoxesBerufClear;
      CB_Fachrichtung.Items.Add('Bürokommunikation');
      CB_Fachrichtung.Items.Add('Hauswirtschaft');
      CB_Fachrichtung.Items.Add('Küche');
      CB_Fachrichtung.Items.Add('Verkauf_FP'); //FP=Fachpraktiker

      CB_Ausbildungsgruppe.Items.Add('IngE-FP');
     end;
end;

procedure Tfrm_BTZ_Bibliothek.CB_EANKeyPress(Sender: TObject; var Key: char);
begin // nur Zifferneingabe und Löschen möglich
 if not(key in[#8,'0'..'9']) then key:=#0;
end;

procedure Tfrm_BTZ_Bibliothek.CB_ErscheinungsjahrKeyPress(Sender: TObject;
  var Key: char);
begin // nur Zifferneingabe und Löschen möglich
 if not(key in[#8,'0'..'9']) then key:=#0;
end;

procedure Tfrm_BTZ_Bibliothek.bt_neuClick(Sender: TObject);
begin
 {Die ID eines neuen Buches ist stets die nächste Zahl nach der Anzahl der
   bereits im Listenfeld eingetragener Bücher}
   LE_BuchID.Text:=IntToStr((List_Buecher.Items.Count)+1);

 //Eingabezeilen in allen Text- und Kombinationsfelder leeren
 //Buchdaten
   CB_EAN.Text:='';
   CB_Titel.Text:='';
   CB_Kurztitel.Text:='';
   CB_Verlag.Text:='';
   Img_Titelbild.Picture.Clear;
   CB_Auflage.Text:='';;
   CB_Erscheinungsjahr.Text:='';
   CB_Seitenzahl.Text:='';
 //Autordaten
   CB_Vorname.Text:='';
   CB_Nachname.Text:='';
 //Berufsdaten
   CB_Berufsbezeichnung.ItemIndex:=-1;
   CB_Fachrichtung.Clear;
   CB_Kurzbezeichnung.Clear;
   CB_Ausbildungsraum.Clear;
   CB_Ausbildungsgruppe.Clear;
 //gleiches Ereignis, wei beim Erzeugen (Laden) des Formulars
   frm_BTZ_Bibliothek.FormCreate(Sender);
end;

procedure Tfrm_BTZ_Bibliothek.bt_loeschenClick(Sender: TObject);
begin
 if (List_Buecher.Items.Count >= 1) then
 //wenn Liste mindestens einen Datensatz enthält
  begin
   if (List_Buecher.ItemIndex <> -1) then //wenn ein Datensatz ausgewählt wurde
    begin
     CB_EAN.Items.Delete(List_Buecher.ItemIndex);
     CB_Titel.Items.Delete(List_Buecher.ItemIndex);
     CB_Kurztitel.Items.Delete(List_Buecher.ItemIndex);
     CB_Verlag.Items.Delete(List_Buecher.ItemIndex);
     CB_Auflage.Items.Delete(List_Buecher.ItemIndex);
     CB_Erscheinungsjahr.Items.Delete(List_Buecher.ItemIndex);
     CB_Seitenzahl.Items.Delete(List_Buecher.ItemIndex);
     CB_Vorname.Items.Delete(List_Buecher.ItemIndex);
     CB_Nachname.Items.Delete(List_Buecher.ItemIndex);
     List_Buecher.Items.Delete(List_Buecher.ItemIndex);
    end
    else showMessage('Es wurde kein Datensatz zum Löschen ausgewählt.');
  end
  else showMessage('Es sind keine Daten zum Löschen verfügbar.');
end;

procedure Tfrm_BTZ_Bibliothek.bt_erster_DSClick(Sender: TObject);
begin
 if (List_Buecher.Items.Count>=1) then
  //wenn Liste mindestens einen Datensatz enthält
  begin
   LE_BuchID.Text:=IntToStr(1);
   //IntToStr: Umwandeln von Ganzzahl in Zeichenkette bei Textausgabe
   List_Buecher.ItemIndex:=0;
   CB_EAN.ItemIndex:=0;
   CB_Titel.ItemIndex:=0;
   CB_Kurztitel.ItemIndex:=0;
   CB_Verlag.ItemIndex:=0;
   CB_Auflage.ItemIndex:=0;
   CB_Erscheinungsjahr.ItemIndex:=0;
   CB_Seitenzahl.ItemIndex:=0;
   CB_Vorname.ItemIndex:=0;
   CB_Nachname.ItemIndex:=0;
  end
  else  //wenn kein Datensatz ausgewählt oder vorhanden ist
   showMessage('Es stehen nicht überall die geforderten Daten zur Verfügung.');
end;

procedure Tfrm_BTZ_Bibliothek.bt_naechster_DSClick(Sender: TObject);
begin
  if(List_Buecher.Items.Count>=2) and
    (StrToInt(LE_BuchID.Text)<List_Buecher.Items.Count) and
    (List_Buecher.ItemIndex<List_Buecher.Items.Count-1) and
    (List_Buecher.ItemIndex<>-1) then

  //wenn mind. 2 DS vorhanden und jeder bis auf den letzten DS ausgewählt
   begin
    LE_BuchID.Text:=IntToStr(StrToInt(LE_BuchID.Text)+1);
    List_Buecher.ItemIndex:=List_Buecher.Itemindex+1;
    CB_EAN.ItemIndex:=CB_EAN.Itemindex+1;
    CB_Titel.ItemIndex:=CB_Titel.Itemindex+1;
    CB_Kurztitel.ItemIndex:=CB_Kurztitel.Itemindex+1;
    CB_Verlag.ItemIndex:=CB_Verlag.Itemindex+1;
    CB_Auflage.ItemIndex:=CB_Auflage.Itemindex+1;
    CB_Erscheinungsjahr.ItemIndex:=CB_Erscheinungsjahr.Itemindex+1;
    CB_Seitenzahl.ItemIndex:=CB_Seitenzahl.Itemindex+1;
    CB_Vorname.ItemIndex:=CB_Vorname.Itemindex+1;
    CB_Nachname.ItemIndex:=CB_Nachname.Itemindex+1;
   end //kein DS ausgewählt, letzter DS oder weniger als 2 DS vorhanden
   else showMessage('Sprung zum nächsten Datensatz nicht möglich!');
end;

procedure Tfrm_BTZ_Bibliothek.bt_TitelbildClick(Sender: TObject);
begin
 if (OD_Titelbild.Execute=true) then // wenn Öffnen-Dialogfeld ausgeführt
  begin
   Img_Titelbild.Picture.LoadFromFile(OD_Titelbild.FileName);
  end
  else  // wenn Öffnen-Dialogfeld geschlossen oder abgebrochen wurde
   begin
    showMessage('Ladefehler!');
   end;
end;

procedure Tfrm_BTZ_Bibliothek.bt_letzter_DSClick(Sender: TObject);
begin
 if(List_Buecher.Items.Count>=1) then
  // wenn Liste mindestens einen Datensatz enthält
  begin //da der ItemIndex mit 0 beginnt, letzter DS = Anzahl-1
   List_Buecher.ItemIndex:=List_Buecher.Items.Count-1;
   CB_EAN.ItemIndex:=CB_EAN.Items.Count-1;
   CB_Titel.ItemIndex:=CB_Titel.Items.Count-1;
   CB_Kurztitel.ItemIndex:=CB_Kurztitel.Items.Count-1;
   CB_Verlag.ItemIndex:=CB_Verlag.Items.Count-1;
   CB_Auflage.ItemIndex:=CB_Auflage.Items.Count-1;
   CB_Erscheinungsjahr.ItemIndex:=CB_Erscheinungsjahr.Items.Count-1;
   CB_Seitenzahl.ItemIndex:=CB_Seitenzahl.Items.Count-1;
   CB_Vorname.ItemIndex:=CB_Vorname.Items.Count-1;
   CB_Nachname.ItemIndex:=CB_Nachname.Items.Count-1;
   LE_BuchID.Text:=IntToStr(List_Buecher.ItemIndex+1);
  end
  else //wenn kein DS zur Verfügung steht
   showMessage('Es stehen nicht überall die geforderten Daten zur Verfügung.');
end;

procedure Tfrm_BTZ_Bibliothek.bt_speichernClick(Sender: TObject);
var Datei:Textfile;
    Eintrag:string;
begin  // wenn alle Kobinationsfelder sowie Titelbildfeld leer sind
 if(CB_EAN.Text='') or(CB_Titel.Text='') or(CB_Kurztitel.Text='')
 or(CB_Verlag.Text='') or(Img_Titelbild.IsVisible=false)
 or(CB_Auflage.Text='') or(CB_Erscheinungsjahr.Text='')
 or(CB_Seitenzahl.Text='') or(CB_Vorname.Text='') or(CB_Nachname.Text='')
 or(CB_Berufsbezeichnung.ItemIndex=-1) or(CB_Fachrichtung.Text='')
 or(CB_Kurzbezeichnung.Text='') or(CB_Ausbildungsraum.Text='')
 or(CB_Ausbildungsgruppe.Text='') then
 showMessage('Es stehen nicht überall Daten zur Verfügung!')
 else  //wenn alles mit Daten (einschließlich Titelbild) gefüllt ist
  begin
   if (SD_Daten.Execute=true) then // wenn Speichern-Dialogfeld ausgeführt
    begin
     assignfile(Datei,SD_Daten.FileName);
     rewrite(Datei);
     Eintrag:=''; //#9=Tabulator (gleichmäßiger Abstand), #13=Zeilenumbruch
       Eintrag:=Eintrag+'Buch'+#13+
       #9+'EAN:'+#9+#9+#9+#9+CB_EAN.Text+#13+
       #9+'Titel:'+#9+#9+#9+CB_Titel.Text+#13+
       #9+'Kurztitel:'+#9+#9+#9+CB_Kurztitel.Text+#13+
       #9+'Verlag:'+#9+#9+#9+CB_Verlag.Text+#13+
       #9+'Auflage:'+#9+#9+#9+CB_Auflage.Text+#13+
       #9+'Erscheinungsjahr:'+#9+CB_Erscheinungsjahr.Text+#13+
       #9+'Seitenzahl:'+#9+#9+#9+CB_Seitenzahl.Text+#13+#13+

       'Autor'+#13+#9+'Vorname: '+#9+#9+#9+CB_Vorname.Text+#13+
                   #9+'Nachname:'+#9+#9+#9+CB_Nachname.Text+#13+#13+

       'Beruf'+#13+#9+'Bezeichnung:'+#9+#9+CB_Berufsbezeichnung.Text+#13+
                   #9+'Fachrichtung:'+#9+#9+CB_Fachrichtung.Text+#13+
                   #9+'Kurzbezeichnung:'+#9+#9+CB_Kurzbezeichnung.Text+#13+
                   #9+'Ausbildungsraum:'+#9+#9+CB_Ausbildungsraum.Text+#13+
                   #9+'Ausbildungsgruppe:'+#9+CB_Ausbildungsgruppe.Text+#13+
                   #13+#13;
       writeln(Datei,Eintrag);
       closefile(Datei);

       List_Buecher.Items.Add(CB_Titel.Text);
       CB_EAN.Items.Add(CB_EAN.Text);
       CB_Titel.Items.Add(CB_Titel.Text);
       CB_Kurztitel.Items.Add(CB_Kurztitel.Text);
       CB_Verlag.Items.Add(CB_Verlag.Text);
       CB_Auflage.Items.Add(CB_Auflage.Text);
       CB_Erscheinungsjahr.Items.Add(CB_Erscheinungsjahr.Text);
       CB_Seitenzahl.Items.Add(CB_Seitenzahl.Text);
       CB_Vorname.Items.Add(CB_Vorname.Text);
       CB_Nachname.Items.Add(CB_Nachname.Text);
    end
    else // wenn Speichern-Dialogfeld geschlossen oder abgebrochen
     begin
      showMessage('Speicherfehler!');
     end;
  end;//else (wenn Daten vorhanden)
end;

procedure Tfrm_BTZ_Bibliothek.bt_vorheriger_DSClick(Sender: TObject);
begin
  if(List_Buecher.Items.Count>=2) and (StrToInt(LE_BuchID.Text)>=2) and
    (List_Buecher.ItemIndex>=1) then
  //wenn mind. 2 DS vorhanden und jeder bis auf den ersten DS ausgewählt
   begin
    LE_BuchID.Text:=IntToStr(StrToInt(LE_BuchID.Text)-1);
    List_Buecher.ItemIndex:=List_Buecher.Itemindex-1;
    CB_EAN.ItemIndex:=CB_EAN.Itemindex-1;
    CB_Titel.ItemIndex:=CB_Titel.Itemindex-1;
    CB_Kurztitel.ItemIndex:=CB_Kurztitel.Itemindex-1;
    CB_Verlag.ItemIndex:=CB_Verlag.Itemindex-1;
    CB_Auflage.ItemIndex:=CB_Auflage.Itemindex-1;
    CB_Erscheinungsjahr.ItemIndex:=CB_Erscheinungsjahr.Itemindex-1;
    CB_Seitenzahl.ItemIndex:=CB_Seitenzahl.Itemindex-1;
    CB_Vorname.ItemIndex:=CB_Vorname.Itemindex-1;
    CB_Nachname.ItemIndex:=CB_Nachname.Itemindex-1;
   end //kein DS ausgewählt, erster DS oder weniger als 2 DS vorhanden
   else showMessage('Sprung zum vorherigen Datensatz nicht möglich!');
end;

procedure Tfrm_BTZ_Bibliothek.CB_AuflageKeyPress(Sender: TObject; var Key: char
  );
begin
 if not(key in[#8,'0'..'9']) then key:=#0;
end;

procedure Tfrm_BTZ_Bibliothek.CB_FachrichtungChange(Sender: TObject);
begin
 CB_Kurzbezeichnung.Clear; // Kombinationsfeld zur Kurzbezeichnung leeren

 if (CB_Berufsbezeichnung.ItemIndex=0) then
 // wenn Fachinformatiker ausgewählt
  begin
   case CB_Fachrichtung.ItemIndex of
    0: CB_Kurzbezeichnung.Items.Add('FIAE');
    1: CB_Kurzbezeichnung.Items.Add('FISI');
   end;
  end

  else if (CB_Berufsbezeichnung.ItemIndex=1) then
  // wenn Mediengestalter ausgewählt
   begin
    CB_Kurzbezeichnung.Clear; // Kombinationsfeld zur Kurzbezeichnung leeren
    if (CB_Fachrichtung.ItemIndex=0) then CB_Kurzbezeichnung.Items.Add('MG');
   end

  else if (CB_Berufsbezeichnung.ItemIndex=2) then
  // wenn Kaufleute ausgewählt
   begin
    case CB_Fachrichtung.ItemIndex of //im Falle vom Datensatznummer
     0: CB_Kurzbezeichnung.Items.Add('I_KL'); // Industriekaufleute
     1: CB_Kurzbezeichnung.Items.Add('K_BM'); // Kaufleute für Büromanagement
     2: CB_Kurzbezeichnung.Items.Add('K_EH'); // Kaufleute im Einzelhandel
     3: CB_Kurzbezeichnung.Items.Add('V');    // Verkäufer
    end;
   end

   else if (CB_Berufsbezeichnung.ItemIndex=3) then
   // wenn Fachpraktiker ausgewählt
    begin
     case CB_Fachrichtung.ItemIndex of
      0: CB_Kurzbezeichnung.Items.Add('FP_BK');  // FP_Bürokommunikation
      1: CB_Kurzbezeichnung.Items.Add('FP_HWT'); // FP_Hauswirtschaft
      2: CB_Kurzbezeichnung.Items.Add('FP_K');   // FP_Küche
      3: CB_Kurzbezeichnung.Items.Add('FP_V');   // FP_Verkauf
     end;//case of

     if (CB_Fachrichtung.ItemIndex=1) or (CB_Fachrichtung.ItemIndex=2) then
      begin // wenn Hauswirtschaft oder Küche ausgewählt
       CB_Ausbildungsraum.Clear;
       CB_Ausbildungsraum.Items.Add('3U32'); //Hauswirtschaftsküche
      end
      else  // wenn Bürokommunikation oder Verkauf_FP ausgewählt
       begin
        CB_Ausbildungsraum.Clear;
        CB_Ausbildungsraum.Items.Add('BOB');
      //BOB=alle Räume im BTZ-Erdgeschoss außer 4004 (IngE-IT/MG) und
      //Toilettenräume
       end;
    end;//else if
end;

procedure Tfrm_BTZ_Bibliothek.CB_SeitenzahlKeyPress(Sender: TObject;
  var Key: char);
begin // nur Zifferneingabe und Löschen möglich
 if not(key in[#8,'0'..'9']) then key:=#0;
end;

end.

