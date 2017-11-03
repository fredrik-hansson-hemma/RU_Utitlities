echo "Sätter alla filer så att de blir skrivbara av användare som tillhör gruppen sas (för att förenkla uppladdning av filer)"
echo "Endast root får exekvera dem"
chmod -R 764 *.sh
chown -R root:sas *.sh

echo "Till kataloger ges mer rättigheter eftersom man vill att andra användare ska kunna öppna underkatalogerna"
find . -type d -exec chmod 775 {} +

