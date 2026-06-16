tableextension 50007 "Purch. Inv. Header FL" extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Procurement Reference No."; Code[30])
        {
        }
        field(50001; "Delivery Notifications"; Text[70])
        {
        }
        field(50002; Particulars; Text[80]) { }
        field(50003; "Valid To Date"; Date) { }
        field(50004; "Purchase Description"; Text[100])
        {
        }
        field(50005; "Created Quotes"; Integer) { }
        field(50006; "Store Requisition No."; Code[20])
        {
        }
        field(50007; "External Doc No."; Code[20])
        {
        }
        field(50008; OutstandingQtyExist; Boolean)
        {
        }
        field(50009; "Requester ID"; Code[10])
        {
        }
        field(50010; "Requisition No."; Code[10])
        {
        }

        field(50011; "Doc. Creation Date:"; Date)
        {
        }
        field(50012; "Commitment Budget"; Code[10])
        {
        }
        field(50013; "Installment No."; Integer)
        {
        }
        field(50014; "Non-Contract Transaction"; Boolean)
        {
        }
        field(50015; "Training Schedule No."; Code[10])
        {
        }
        field(50016; "Training Plan No."; Code[10])
        {
        }
        field(50017; "Training LPO No. Series"; Code[10])
        {
        }
        field(50018; "Training Schedule No.1"; Code[10])
        {
        }
        field(50019; "Training Plan No.1"; Code[10])
        {
        }
        field(50020; "Training LPO No. Series1"; Code[10])
        {
        }
        field(50021; "Payment Terms2 Text"; Text[100])
        {
        }
        field(50022; "Delivery Note No"; Code[25])
        {
        }
        field(50023; "Purchase Requisition No."; Code[20])
        {
        }
        field(50024; "Doc. Created By:"; Code[50])
        {
        }
        field(50025; "Equipment No."; code[100])
        {
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            var
                Equipment: Record "Fixed Asset";
            begin
                IF "Equipment No." <> '' THEN BEGIN
                    IF Equipment.GET("Equipment No.") THEN BEGIN
                        Equipment.TestField("Equipment Type");
                        IF Equipment."Blocked" THEN
                            ERROR('Equipment: %1 is blocked.', Equipment."No.")
                        else begin
                            Rec.validate("Equipment Type", Equipment."Equipment Type");
                            Rec.Modify();
                        end;
                    END;
                END else begin
                    "Equipment Type" := '';
                    Rec.Modify();
                end;
            end;
        }
        field(50026; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
        }
        field(50027; "Responsible Employee"; Code[50])
        {
            TableRelation = Employee."No.";
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

    var
        myInt: Integer;
}