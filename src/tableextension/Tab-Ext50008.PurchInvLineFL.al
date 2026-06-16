tableextension 50008 "Purch. Inv. Line FL" extends "Purch. Inv. Line"
{
    fields
    {
        field(50000; "Qty. Requested"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50001; "Request-By No."; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(50002; "Request-By Name"; Text[50])
        {
        }
        field(50003; "G/L Expense A/c"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50004; "Pay to Type"; Option)
        {
            OptionCaption = ' ,Vendor,Staff,Other';
            OptionMembers = " ",Vendor,Staff,Other;
        }
        field(50005; "Pay to No."; Code[20])
        {
            TableRelation = IF ("Pay to Type" = FILTER(Vendor)) Vendor."No."
            ELSE
            IF ("Pay to Type" = FILTER(Staff)) Employee."No.";

            trigger OnValidate();
            var
                EmpRec: Record Employee;
                VendRec: Record Vendor;
            begin
                CASE "Pay to Type" OF
                    "Pay to Type"::Vendor:
                        BEGIN
                            IF "Pay to No." <> '' THEN BEGIN
                                VendRec.GET("Pay to No.");
                                "Pay to Name" := VendRec.Name;
                            END;
                        END;
                    "Pay to Type"::Staff:
                        BEGIN
                            IF "Pay to No." <> '' THEN BEGIN
                                EmpRec.GET("Pay to No.");
                                "Pay to Name" := EmpRec.FullName;
                            END;
                        END;
                END;
            end;
        }
        field(50006; "Pay to Name"; Text[80])
        {
        }
        field(50007; "External Document No."; Code[20])
        {
        }
        field(50008; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(50009; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup();
            var
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
                AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
                AccNo: Code[20];
            begin
            end;
        }
        field(50010; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
        }
        field(50011; "Invoiced Amount"; Decimal)
        {
            Description = 'Used in the LPO pages list: JCK 13.08.12';
        }
        field(50012; "WHT Code"; Code[20])
        {
        }
        field(50013; "Include in Purch. Order"; Boolean)
        {
        }
        field(50014; "Inventory Charge A/c"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50015; "Total Cost"; Decimal)
        {
        }
        field(50016; "Control Account"; Code[20])
        {
            Description = 'Holds a control account for an Item or Fixed Asset Purchase line Commitment';
            Editable = false;
            TableRelation = "G/L Account"."No.";
        }
        field(50017; "Commitment Entry No."; Integer)
        {
            Description = 'Identifies a line that has been committed';
        }
        field(50018; "Direct Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FIELDNO("Direct Unit Cost (LCY)"));
            Caption = 'Direct Unit Cost (LCY)';
            Description = 'Handles the LCY Amount for Direct Unit Cost';
            Editable = false;
        }
        field(50019; "Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Line Amount (LCY)"));
            Caption = 'Line Amount (LCY)';
            Description = 'Handles the LCY Amount for Line Amount';
            Editable = false;

        }
        field(50020; "Doc. Created By"; Code[50])
        {
        }
        field(50021; "Doc. Creation Date"; Date)
        {
        }
        field(50022; "Advance Code"; Code[20])
        {
            Description = 'Staff Members'' Codes for tracking advances and loans';
            TableRelation = Employee."No.";
        }
        field(50023; "Commitment Budget"; Code[10])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50024; "non contract"; Boolean)
        {
            Description = 'rRe';
        }
        field(50025; "Transfer to Item Jnl"; Boolean)
        {
        }
        field(50026; "Make Purchase Req."; Boolean)
        {
        }
        field(50027; "Qty To Transfer to Item Jnl"; Decimal)
        {
        }
        field(50028; "Qty To Make Purch. Req."; Decimal)
        {
        }
        field(50029; "Transferred To Item Jnl"; Boolean)
        {
            Editable = false;
        }
        field(50030; "Transferred To Purch. Req."; Boolean)
        {
            Editable = false;
        }
        field(50031; CurrentBeingUsed; Boolean)
        {
        }
        field(50032; "Total Qty To Item Jnl"; Decimal)
        {
            Editable = false;
        }
        field(50033; "Total Qty To Purch. Req"; Decimal)
        {
            Editable = false;
        }
        field(50034; "Req. Reserved Quantity"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                   "Source Ref. No." = FIELD("Line No."),
                                                                   "Reservation Status" = CONST(Reservation)));
            FieldClass = FlowField;
        }
        field(50035; "Qty Returned"; Decimal)
        {

            trigger OnValidate();
            var
                lvStoreReturn: Record "ADT Requisition Line";
            begin
            end;
        }
        field(50036; "Archive No."; Code[20])
        {
        }
        field(50037; "Qty. Not Returned"; Decimal)
        {

            trigger OnValidate();
            var
                lvStoreReturn: Record "ADT Requisition Line";
            begin
            end;
        }
        field(50038; "Store Issue Line No"; Integer)
        {
        }
        field(50039; "Equipment No."; code[100])
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
        field(50040; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
        }
        field(50041; "Responsible Employee"; Code[50])
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