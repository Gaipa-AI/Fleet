tableextension 50002 "G/L Account FL" extends "G/L Account"
{
    fields
    {
        field(50000; "Prepayment Account"; Boolean)
        {
            Description = 'Specifies whether an account is used as a prepayment account.';
        }
        field(50001; "Payment Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = " ",Cash,Cheque,Voucher;
        }
        field(50002; "Advance Posting"; Option)
        {
            OptionMembers = " ","Code Mandatory","No Code";
        }
        field(50003; "Include in Budget Check"; Boolean)
        {
            InitValue = true;
        }
        field(50004; "Spare1 Filter"; Code[120])
        {
            CaptionClass = '1,3,6';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SPARE1'));
        }
        field(50005; "Spare2 Filter"; Code[120])
        {
            CaptionClass = '1,3,7';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SPARE2'));
        }
        field(50006; "Spare3 Filter"; Code[120])
        {
            CaptionClass = '1,3,8';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SPARE3'));
        }
        field(50007; "VoteCostCenter Filter"; Code[120])
        {
            CaptionClass = '1,3,3';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('VOTE COST CENTRE'));
        }
        field(50008; "Revenue Account"; Boolean)
        {
        }
        field(50009; "Budgeted Amount ACY"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = field("No."),
                                                               "G/L Account No." = FIELD(FILTER(Totaling)),
                                                               "Business Unit Code" = FIELD("Business Unit Filter"),
                                                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                               Date = FIELD("Date Filter"),
                                                               "Budget Name" = FIELD("Budget Filter")));
            Caption = 'Budget at Date';
            Description = '//Added to Sum up the Budgeted Column in additional reporting currency';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Fund Filter"; Code[120])
        {
            CaptionClass = '1,3,4';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FUND'));
        }
        field(50011; "FundingSource Filter"; Code[120])
        {
            CaptionClass = '1,3,5';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FUNDING SOURCE'));
        }
        field(50012; "Force Revenue Stream"; Boolean)
        {
        }
        field(50013; "Media Type"; Code[20])
        {
        }
        field(50014; "Expense Account"; Boolean)
        {

            trigger OnValidate();
            begin

                IF "Income/Balance" = "Income/Balance"::"Balance Sheet" THEN
                    ERROR('Please select an income statement account');
            end;
        }
        field(50015; "Tax Account"; Boolean)
        {
            Description = 'Ensures that tax accounts are excluded on the payment voucher';
        }
        field(50016; "Cash collection Account"; Boolean)
        {
        }
    }

    var
        myInt: Integer;
}