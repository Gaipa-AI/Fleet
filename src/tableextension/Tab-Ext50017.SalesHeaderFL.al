tableextension 50017 "Sales Header FL" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Equipment Hire No."; Code[30])
        {
            TableRelation = "Form Header"."No.";
        }
        field(50001; "Equipment Hire Invoice"; Boolean)
        {
            Editable = false;
        }
        field(50002; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
        }
        field(50003; "Hire Request No."; code[50])
        {
            TableRelation = "Form Header"."No.";
        }
        field(50004; "Hire Type"; Option)
        {
            //TableRelation = "Form Header"."No.";
            OptionMembers = " ",INTERNAL,EXTERNAL;
            Editable = true;

            trigger OnValidate()
            begin
                AssignHireRequestNoIfEmpty();
            end;
        }
        field(50005; "Equipment No."; Code[20])
        {
           
            TableRelation = "Fixed Asset"."No." where("Equipment Status" = filter(Available));
            

            trigger OnValidate()
            var
                Equipment: Record "Fixed Asset";
                Employee: Record "Employee";
                begin
                    if Equipment.Get("Equipment No.") then begin
                    
                    "Equipment Name" := Equipment.Description;
                    end;
                    AssignHireRequestNoIfEmpty();
                    

                end;
        }
        field(50006; "Equipment Name"; Text[250])
        {
            Caption = 'Equipment Name';
            DataClassification = ToBeClassified;

        }

        
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    local procedure AssignHireRequestNoIfEmpty()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if ("Hire Request No." <> '') or ("Equipment No." = '') or ("Hire Type" = "Hire Type"::" ") then
            exit;

        case "Hire Type" of
            "Hire Type"::INTERNAL:
                "Hire Request No." := NoSeriesMgt.GetNextNo('INTH', WorkDate(), true);
            "Hire Type"::EXTERNAL:
                "Hire Request No." := NoSeriesMgt.GetNextNo('EXTH', WorkDate(), true);
        end;
    end;




    var
        myInt: Integer;

        IsEditable: Boolean;
}