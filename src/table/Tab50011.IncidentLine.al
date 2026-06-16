table 50011 "Incident Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; enum "Form Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            OptionMembers = " ",Corrective,Recommendation;
        }
        field(5; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            OptionMembers = " ",Pending,Closed;
        }
        field(7; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Responsible Party"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
                
            begin

                if Rec."Employee No." <> '' then
                    
                    if Employee.Get(Rec."Employee No.") then begin
                        Rec.Name := Employee.FullName();
                        Rec."Employee Type" := Employee."Employee Type";
                    end;
            end;
        }
        field(10; Name; Text[200])
        {
            Editable = false;
        }
        field(11; "Employee Type"; Code[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", Type, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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