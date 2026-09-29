table 50016 Persons
{
    Caption = 'Persons';
    DataClassification = ToBeClassified;
    //LookupPageId = "Persons";
    
    fields
    {
        field(1; "Person ID"; Code[40])
        {
            Caption = 'Id';
            trigger OnValidate()
            var 
            Setup: Record "Fleet Management Setup";
            NoSeries: Codeunit "No. Series";

            begin
                if "Person ID" <> xRec."Person ID" then begin
                    Setup.Get();
                    Setup.TestField("Person IDs");
                    NoSeries.TestManual(Setup."Person IDs");
                    "No. Series" := '';
                    
                end;

            end;
        }
        field(2; name; Text[250])
        {
            Caption = 'Name';
        }
        field(3; contact; Code[15])
        {
            Caption = 'Phone Contact';
        }
        field(4; email; Text[100])
        {
            Caption = 'Email';
        }
        field(5; title; Text[100])
        {
            Caption = 'Title';
        }
        field(6; "work location"; Text[250])
        {
            Caption = 'Work Location';
        }
        field(7; "site manager"; Text[250])
        {
            Caption = 'Site Manager';
        }
        field(8;"No. Series"; Code[20])
        {
            
        }
    }
    keys
    {
        key(PK; "Person ID")
        {
            Clustered = true;
        }
        key(Name; name)
        {

        }
    }

    trigger OnInsert()
    var
    Setup: Record "Fleet Management Setup";
    NoSeries: Codeunit "No. Series";
    
    begin
        if "Person ID"='' then begin
            Setup.Get();
            Setup.TestField("Person IDs");
            "No. Series" := Setup."Person IDs";
            "Person ID":= NoSeries.GetNextNo("No. Series")
        end;

    end;
}
