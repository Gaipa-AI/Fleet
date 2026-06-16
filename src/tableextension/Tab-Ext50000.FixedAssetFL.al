tableextension 50000 "Fixed Asset FL" extends "Fixed Asset"
{
    fields
    {
        field(50000; "Equipment Status"; Enum "Equipment Status")
        {
            Caption = 'Equipment Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
        }
        field(50002; Make; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Model; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Registration No."; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Vehicle Mileage"; Decimal)
        {
            //TableRelation = Employee."No.";
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 1;
            trigger OnValidate()
            begin
            if Rec."Vehicle Mileage" >= Rec."Next Service At Mileage" then begin
                Rec."Serviced" := false;
                Rec.Modify()
            end
            else
                Rec."Serviced" := true;
                Rec.Modify();

            end;
        }
        field(50005; "Next Service At Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "3RD Party Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Service Interval"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Serviced"; Boolean)
        { 
            DataClassification = ToBeClassified;
            //Editable = true;    

        }
        field(50010; "Service Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        // field(50011;"Asset Location";Code[20])
        // {
        //     TableRelation = Location.Code;
        // }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    //function to put equipment out of operation
    procedure PutEquipmentOutOfOperation()
    var
        FixedAsset: Record "Fixed Asset";
    begin
        if FixedAsset.Get(Rec."No.") then begin
            FixedAsset."Equipment Status" := FixedAsset."Equipment Status"::"Not in Operation";
            FixedAsset.Modify();
        end;
    end;
}