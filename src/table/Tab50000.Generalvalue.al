table 50000 "General value"
{
    Caption = 'General Value';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Type; Enum "Generic Enum")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(2; Code; Code[100])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Equipment No."; Text[250])
        {
            TableRelation = "Fixed Asset"."No.";
            Caption = 'Equipment No.';
        }
        field(5; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, Code, "Equipment No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type, "Equipment No.")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {

        }
        fieldgroup(Brick; Code, Description)
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        LineNo: Integer;
        WorkCondition: Record "General value";
    begin
        // Code to execute when a new record is inserted
        Rec."Date" := Today();
        //increment line number
        WorkCondition.SetRange(Type, Rec.Type);
        WorkCondition.SetRange("Equipment No.", Rec."Equipment No.");
        if WorkCondition.FindLast() then
            LineNo := WorkCondition."Line No."
        else
            LineNo := 0;
        Rec."Line No." := LineNo + 1000;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}