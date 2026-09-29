table 50017 "User Location Setup"
{
    Caption = 'User Location Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"User ID";Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()var UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("User ID");
            end;
        }
        field(2;Location;Code[20])
        {
            Caption = 'Location';
            TableRelation = Location;

            trigger OnValidate()var LocRec: Record Location;
            begin
                Clear(Description);
                if LocRec.Get(Location)then Description:=LocRec.Name;
            end;
        }
        field(3;Description;Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(4;Check;Boolean)
        {
        }
        field(5;Loc;Boolean){
            
        }
        field(6;CMR;Boolean){
            
        }
    }
    keys
    {
        key(PK;"User ID", Location)
        {
            Clustered = true;
        }
    }

}
